variable "vpc_id" {
  description = "The VPC ID where subnets will be created"
  type        = string
}

variable "availability_zones" {
  description = "List of AZs to use (e.g., [\"us-east-1a\", \"us-east-1b\"])"
  type        = list(string)

  validation {
    condition     = length(var.availability_zones) == 2
    error_message = "Exactly 2 Availability Zones must be provided."
  }
}

variable "public_subnet_cidrs" {
  description = "List of 2 CIDRs for public subnets"
  type        = list(string)

  validation {
    condition     = length(var.public_subnet_cidrs) == 2
    error_message = "Exactly 2 CIDRs must be provided for public subnets."
  }
}

variable "tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}

variable "name_prefix" {
  description = "Prefix for subnet names"
  type        = string
}
