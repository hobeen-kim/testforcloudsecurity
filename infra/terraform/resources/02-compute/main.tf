data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "terraform-states-589794546244"
    key    = "networking/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

module "alb_security_group" {
  source = "../../modules/security-group"
  name   = "alb-sg"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  tags   = merge(var.tags)
}

module "alb_security_rule_443" {
  source            = "../../modules/security-rule"
  security_group_id = module.alb_security_group.id
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "alb ingress rule from 443"
}

module "alb_security_rule_80" {
  source            = "../../modules/security-rule"
  security_group_id = module.alb_security_group.id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "alb ingress rule from 80"
}

module "alb" {
  source            = "../../modules/alb"
  name              = "main-alb"
  vpc_id            = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids        = data.terraform_remote_state.network.outputs.public_subnet_ids
  security_group_id = module.alb_security_group.id
  target_port       = var.target_port
  tags              = merge(var.tags)
  certificate_arn   = data.terraform_remote_state.network.outputs.acm_certificate_arn
}

data "aws_ami" "amazon_linux_arm64" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-arm64"]
  }
}

module "ec2_security_group" {
  source = "../../modules/security-group"
  name   = "ec2-sg"
  vpc_id = data.terraform_remote_state.network.outputs.vpc_id
  tags   = merge(var.tags)
}

module "ec2_security_rule" {
  source                   = "../../modules/security-rule"
  security_group_id        = module.ec2_security_group.id
  type                     = "ingress"
  from_port                = var.target_port
  to_port                  = var.target_port
  protocol                 = "tcp"
  source_security_group_id = module.alb_security_group.id
  description              = "ec2 ingress rule from alb"
}

module "ec2_security_rule_from_ssh" {
  source            = "../../modules/security-rule"
  security_group_id = module.ec2_security_group.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = [var.my_ip]
  description       = "ssh ingress rule from my ip"
}

module "ec2_iam_role" {
  source             = "../../modules/iam-role"
  tags               = merge(var.tags)
  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
  description        = ""
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
  policy_name = "ec2-iam-role-policy"
  role_name   = "ec2-iam-role"
}

module "asg" {
  source            = "../../modules/autoscaling-group"
  name              = "web-asg"
  ami_id            = data.aws_ami.amazon_linux_arm64.id
  instance_type     = var.instance_type
  key_name          = var.key_name
  security_group_id = module.ec2_security_group.id
  subnet_ids        = data.terraform_remote_state.network.outputs.public_subnet_ids
  target_group_arns = [module.alb.aws_lb_target_group.arn]
  min_size          = 1
  max_size          = 1
  desired_capacity  = 1
  user_data_base64  = base64encode(var.user_data)
  tags              = merge(var.tags)
  instance_profile = module.ec2_iam_role.iam_role_name
}

