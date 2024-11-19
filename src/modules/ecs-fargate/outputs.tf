# Outputs for the ECS Cluster
output "ecs_cluster_id" {
  description = "The ID of the ECS cluster"
  value       = aws_ecs_cluster.csntp_cluster.id
}

output "ecs_cluster_name" {
  description = "The name of the ECS cluster"
  value       = aws_ecs_cluster.csntp_cluster.name
}

# Outputs for the ECS Task Definition
output "ecs_task_definition_arn" {
  description = "The ARN of the ECS task definition"
  value       = aws_ecs_task_definition.csntp_task_definition.arn
}

output "ecs_task_definition_family" {
  description = "The family of the ECS task definition"
  value       = aws_ecs_task_definition.csntp_task_definition.family
}

# Outputs for the ECS Service
output "ecs_service_id" {
  description = "The ID of the ECS service"
  value       = aws_ecs_service.csntp_service.id
}

output "ecs_service_name" {
  description = "The name of the ECS service"
  value       = aws_ecs_service.csntp_service.name
}

output "ecs_service_desired_count" {
  description = "The desired count of tasks for the ECS service"
  value       = aws_ecs_service.csntp_service.desired_count
}

# Outputs for CloudWatch Log Group
output "cloudwatch_log_group_name" {
  description = "The name of the CloudWatch log group for ECS logs"
  value       = aws_cloudwatch_log_group.csntp_ecs_logs.name
}

# Outputs for IAM Roles
output "ecs_task_execution_role_arn" {
  description = "The ARN of the ECS task execution role"
  value       = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_task_role_arn" {
  description = "The ARN of the ECS task role"
  value       = aws_iam_role.ecs_task_role.arn
}