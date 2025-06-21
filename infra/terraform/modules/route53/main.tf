resource "aws_route53_record" "dns_record" {
  for_each = { for r in var.dns_records : r.name => r }

  zone_id = var.zone_id
  name    = each.value.name
  type    = each.value.type
  allow_overwrite = true

  dynamic "alias" {
    for_each = each.value.type == "A" ? [1] : []
    content {
      name                   = each.value.alias.name
      zone_id                = each.value.alias.zone_id
      evaluate_target_health = each.value.alias.evaluate_target_health
    }
  }

  records = each.value.type == "CNAME" ? each.value.records : null
  ttl     = each.value.type == "CNAME" ? each.value.ttl : null
}