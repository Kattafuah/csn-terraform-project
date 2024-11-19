output "alb_dns_name" {
  value = aws_lb.csntp_elb.dns_name
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.csntp_target_group.arn
}

output "target_group_name" {
  description = "The name of the target group"
  value       = aws_lb_target_group.csntp_target_group.name
}

output "target_group_port" {
  description = "The port of the target group"
  value       = aws_lb_target_group.csntp_target_group.port
}

output "target_group_health_check_path" {
  description = "The health check path of the target group"
  value       = aws_lb_target_group.csntp_target_group.health_check[0].path
}

output "target_group_health_check_protocol" {
  description = "The health check protocol of the target group"
  value       = aws_lb_target_group.csntp_target_group.health_check[0].protocol
}

output "zone_id" {
  description = "The zone ID of the load balancer"
  value       = aws_lb.csntp_elb.zone_id
}
