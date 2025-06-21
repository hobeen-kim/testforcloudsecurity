data "terraform_remote_state" "compute" {
  backend = "s3"
  config = {
    bucket = "terraform-states-589794546244"
    key    = "compute/terraform.tfstate"
    region = "ap-northeast-2"
  }
}

data "aws_route53_zone" "main" {
  name         = "hobeenkim.com"
  private_zone = false
}

module "route53" {
  source = "../../modules/route53"
  dns_records = [
    {
      name = "test.hobeenkim.com"
      type = "A"
      ttl  = 300
      alias = {
        name                   = data.terraform_remote_state.compute.outputs.alb_dns_name
        zone_id                = data.terraform_remote_state.compute.outputs.alb_zone_id
        evaluate_target_health = false
      }
    }
  ]
  zone_id = data.aws_route53_zone.main.zone_id
}