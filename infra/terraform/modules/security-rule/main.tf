resource "aws_security_group_rule" "this" {
  type              = var.type # "ingress" or "egress"
  from_port         = var.from_port
  to_port           = var.to_port
  protocol          = var.protocol
  security_group_id = var.security_group_id
  description       = var.description

  cidr_blocks      = var.cidr_blocks
  source_security_group_id = var.source_security_group_id
}
