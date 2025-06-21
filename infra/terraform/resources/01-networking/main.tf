module "vpc" {
  source     = "../../modules/vpc"
  cidr_block = var.vpc_cidr
  name       = var.vpc_name
  tags       = merge(var.tags)

  providers = {
    aws = aws.sandbox
  }
}

module "internet_gateway" {
  source = "../../modules/internet-gateway"
  name   = "main-internet-gw"
  vpc_id = module.vpc.vpc_id # Now properly referenced
  tags   = merge(var.tags)

  providers = {
    aws = aws.sandbox
  }
}

module "subnets" {
  source = "../../modules/subnets"

  vpc_id              = module.vpc.vpc_id
  availability_zones  = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
  name_prefix         = "main"
  tags                = var.tags
  providers = {
    aws = aws.sandbox
  }
}

module "route_tables" {
  source = "../../modules/route-tables"

  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.subnets.public_subnet_ids
  internet_gateway_id = module.internet_gateway.igw_id
  tags                = var.tags
  providers = {
    aws = aws.sandbox
  }
}

module "acm" {
  source = "../../modules/acm"

  domain_name               = var.acm_domain_names[0]
  subject_alternative_names = slice(var.acm_domain_names, 1, length(var.acm_domain_names))
  zone_id                   = data.aws_route53_zone.main.zone_id
  tags                      = var.tags
}
