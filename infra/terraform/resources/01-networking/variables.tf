# Define the vpc_cidr variable (CIDR block for VPC)
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string

}

# Define a variable for tags
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {} # You can set default tags here if needed
}

# Define a variable for vpc name
variable "vpc_name" {
  description = "name of the VPC"
  type        = string
}

# Define variables for subnets
variable "availability_zones" {
  description = "AZs to use for subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

#certificate varialbles
variable "acm_domain_names" {
  description = "List of domain names for ACM. First one is used as main domain, others as SANs."
  type        = list(string)
}

variable "subject_alternative_names" {
  description = "SANs for the ACM certificate"
  type        = list(string)
  default     = []
}

variable "domain_name" {
  description = "Primary domain for ACM certificate"
  type        = string
}