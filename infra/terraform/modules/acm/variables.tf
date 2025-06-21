variable "domain_name" {
  description = "The main domain name for the certificate"
  type        = string
}

variable "subject_alternative_names" {
  description = "List of SANs (Subject Alternative Names)"
  type        = list(string)
  default     = []
}

variable "zone_id" {
  description = "Route53 Zone ID to create DNS validation records"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the certificate"
  type        = map(string)
}
