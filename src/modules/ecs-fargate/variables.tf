variable "execution_role_arn" {
  description = "The ARN of the IAM role that allows ECS tasks to make AWS API calls."
  type        = string
}

variable "db_host" {
  description = "The hostname of the RDS database for WordPress."
  type        = string
  default     = "CsnDb"
}

variable "ssm_db_user_param" {
  description = "The SSM parameter name for the WordPress DB username."
  type        = string
}

variable "secrets_manager_db_password" {
  description = "The ARN of the Secrets Manager secret that contains the WordPress DB password."
  type        = string
}

# variable "ssm_db_host_param" {
#   description = "The SSM parameter name for the WordPress DB host."
#   type        = string
# }

variable "rds_db_name" {
  type    = string
}

variable "aws_efs_access_point" {
  type    = string
  default = "csntp_efs_access_point"
}

variable "ecs_service_name" {
  default = "ecs_csntp-service"
  type    = string
}


variable "pub_access" {
  type    = bool
  default = false
}

/*variable "ecs_task_role" { 
  default = "arn:aws:iam::431877974142:role/ECS_Task_Definition"
}


variable "ecs_task_execution_role" {
  default = "arn:aws:iam::431877974142:role/ecsTaskExecutionRole"
}*/

variable "rds_identifier" {
  description = "The identifier for the RDS instance"
  type        = string
}

variable "instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "iam_database_authentication_enabled" {
  description = "Enable IAM database authentication"
  type        = bool
}

variable "database_username" {
  type    = string
  default = "admin"
}

variable "route53_zone_id" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "hosted_zone_id" {
    type    = string
}