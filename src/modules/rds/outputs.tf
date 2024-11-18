output "database_username" {
  value = aws_ssm_parameter.database_username.value  # Ensure this resource is declared in the module
}

output "database_password" {
  value = aws_ssm_parameter.database_password.value  # Ensure this resource is declared in the module
}

output "rds_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint  # Ensure this resource is declared in the module
}

output "rds_instance_id" {
  value = aws_db_instance.wordpress_db.id
}