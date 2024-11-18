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

variable "ssm_db_host_param" {
  description = "The SSM parameter name for the WordPress DB host."
  type        = string
}

variable "rds_db_name" {
  type    = string
  default = "csntp_db"
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
