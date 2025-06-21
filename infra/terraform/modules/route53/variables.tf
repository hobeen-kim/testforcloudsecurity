variable "dns_records" {
  description = "List of DNS records"
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    records = optional(list(string))  # Optional for non-alias records
    alias   = optional(object({
      name                   = string
      zone_id                = string
      evaluate_target_health = bool
    }))  # Optional for alias records
  }))
  default     = []
}

variable "zone_id" {
  description = "Hosted zone ID"
  type        = string
}