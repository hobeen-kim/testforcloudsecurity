terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

resource "aws_subnet" "public" {
    count = 2
    vpc_id = var.vpc_id
    cidr_block = var.public_subnet_cidrs[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true
    tags = merge(
        var.tags,
        {
            Name    =  "${var.name_prefix}-public-${count.index + 1}"
            Type    = "public"

        }
    )
}