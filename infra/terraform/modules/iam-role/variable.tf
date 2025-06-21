variable "policy_name" {
  type = string
}

variable "description" {
  type = string
}

variable "policy" {
  type = string
}

variable "role_name" {
  type = string
}

variable "assume_role_policy" {
  type = string
}

variable "tags" {
  type = map(string)
}