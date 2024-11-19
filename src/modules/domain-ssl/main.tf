resource "aws_route53_record" "csntp_dns" {
  zone_id = var.hosted_zone_id
  allow_overwrite = true
  name    = "ingkwasiattafua.com"
  type    = "A"

  alias {
    name                   = module.load-balancer.dns_name
    zone_id                = module.load-balancer.zone_id
    evaluate_target_health = true
  }
}

