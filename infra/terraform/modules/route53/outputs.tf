output "record_names" {
  value = [for record in var.dns_records : record.name]
}
