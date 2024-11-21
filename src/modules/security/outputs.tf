output "rds_security_group" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.rds_security_group.id
}

output "ecs_security_group" {
  description = "The ID of the ECS security group"
  value       = aws_security_group.ecs_security_group.id
}

output "efs_security_group" {
  description = "The ID of the EFS security group"
  value       = aws_security_group.efs_security_group.id
}

output "elb_security_group" {
  description = "The ID of the ELB security group"
  value       = aws_security_group.elb_security_group.id
}