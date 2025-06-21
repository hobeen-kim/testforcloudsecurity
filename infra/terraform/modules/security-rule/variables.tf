variable "type" {
  type = string
  description = "ingress or egress"
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}

variable "protocol" {
  type = string
}

variable "security_group_id" {
  type = string
}

variable "description" {
  type    = string
}

variable "cidr_blocks" {
  type    = list(string)
  default = null
}

variable "source_security_group_id" {
  type    = string
  default = null
}