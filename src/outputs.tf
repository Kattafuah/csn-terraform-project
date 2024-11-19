output "vpc_id" {
  value = module.vpc.aws_vpc.csntp.id
}

output "rds_endpoint" {
  value = module.ecs-fargate.aws_db_instance.wordpress_db.endpoint
}

output "alb_dns_name" {
  value = module.vpc.aws_lb.alb.dns_name
}