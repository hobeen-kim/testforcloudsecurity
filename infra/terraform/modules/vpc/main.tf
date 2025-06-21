terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_hostnames =  var.enable_dns_hostnames
  enable_dns_support = var.enable_dns_support
  tags = merge(var.tags, {  Name  =   var.name  })

}