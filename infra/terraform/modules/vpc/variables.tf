variable "cidr_block" {
  description = "the primary IPv4 CIDR block for the VPC"
  type = string
  validation {
    condition = can(cidrnetmask(var.cidr_block))
    error_message = "Must be a valid IPv4 CIDR block (e.g., 10.0.0.0/16)"
  }
}

variable "name" {
    description = "Name tag for the VPC"
    type = string
}

variable "tags" {
    description = "Additional tags to apply to all resources"
    type = map(string)
    default = {}
  
}

# Optional: Advanced VPC features
variable "enable_dns_support" {
  description = "Should DNS resolution be supported for the VPC?"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Should DNS hostnames be enabled for the VPC?"
  type        = bool
  default     = true
}

# variable "public_subnet_cidrs" {
#   type = list(string)
# }

# variable "private_subnet_cidrs" {
#   type = list(string)
# }