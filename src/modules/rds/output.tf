output "database_username" {
  value = aws_ssm_parameter.database_username.value  # Ensure this resource is declared in the module
}

output "database_password" {
  value = aws_ssm_parameter.database_password.value  # Ensure this resource is declared in the module
}

output "rds_endpoint" {
  value = aws_db_instance.csntp_rds.endpoint  # Ensure this resource is declared in the module
}

output "rds_instance_id" {
  value = aws_db_instance.csntp_rds.id
}

output "rds_db_name" {
  description = "The database name"
  value       = aws_db_instance.csntp_rds.db_name
}

# Outputs for the EFS file system
output "efs_file_system_id" {
  description = "The ID of the EFS file system"
  value       = aws_efs_file_system.csntp_efs.id
}

output "efs_file_system_arn" {
  description = "The ARN of the EFS file system"
  value       = aws_efs_file_system.csntp_efs.arn
}

# Outputs for EFS mount targets
output "efs_mount_target_ids" {
  description = "The IDs of the EFS mount targets"
  value       = [
    aws_efs_mount_target.csntp_efs_mt1.id,
    aws_efs_mount_target.csntp_efs_mt2.id
  ]
}

output "efs_access_point_id" {
  description = "The ID of the EFS access point"
  value       = aws_efs_access_point.csntp_access_pt.id
}

# Outputs for SSM parameters
output "ssm_database_password" {
  description = "The SSM parameter for the database password"
  value       = aws_ssm_parameter.database_password.name  # Only output the name for security reasons
}

output "ssm_database_username" {
  description = "The SSM parameter for the database username"
  value       = aws_ssm_parameter.database_username.name  # Only output the name for security reasons
}
# output "ssm_db_host_param" {
#   value = aws_ssm_parameter.db_host.value  # Adjust this to your actual resource
# }