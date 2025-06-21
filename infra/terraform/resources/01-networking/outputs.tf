output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.subnets.public_subnet_ids
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = module.route_tables.public_route_table_id
}

output "internet_gateway_id" {
  value = module.internet_gateway.igw_id
}

output "acm_certificate_arn" {
  value       = module.acm.certificate_arn
  description = "The ARN of the ACM certificate for use in ALB or other modules"
}

output "acm_domain_names" {
  value       = concat([var.domain_name], var.subject_alternative_names)
  description = "List of all domains covered by the ACM certificate"
}
