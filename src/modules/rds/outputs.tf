output "db_password" {
  description = "The database password generated and stored."
  value       = aws_ssm_parameter.db_password.value  # Adjust this to match your resource
}