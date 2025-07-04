variable "vpc_id" {
  description = "The ID of the VPC to attach the Internet Gateway to"
  type        = string
}

variable "name" {
  description = "Name tag for the Internet Gateway"
  type        = string
}

variable "tags" {
  description = "Additional tags for the Internet Gateway"
  type        = map(string)
  default     = {}
}
