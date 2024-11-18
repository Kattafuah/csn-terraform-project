resource "aws_route53_record" "csntp_dns" {
  zone_id = var.hosted_zone_id
  allow_overwrite = true
  name    = "ingkwasiattafua.com"
  type    = "A"

  alias {
    name                   = aws_lb.csntp_elb.dns_name
    zone_id                = aws_lb.csntp_elb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_lb" "csntp_elb" {
  # Ensure this resource is declared
}