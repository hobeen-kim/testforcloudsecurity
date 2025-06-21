variable "name" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  type = list(string)
}

variable "security_group_id" {
  type = string
}

variable "target_port" {
  type    = number
}

variable "tags" {
  type = map(string)
}

variable "certificate_arn" {
  type = string
}