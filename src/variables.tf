variable "vpc_id" {
  description = "The ID of the VPC where the resources will be deployed."
  type        = string
}

variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
  default     = "csntp_cluster"
}


variable "execution_role_arn" {
  description = "The ARN of the IAM role that ECS tasks will use."
  type        = string
}


variable "db_password" {
  description = "The database password to be stored in Secrets Manager."
  type        = string
}

variable "route53_zone_id" {
  description = "Zone ID of route53 domain"
  type        = string
}

variable "domain_name" {
  description = "Domain name "
  type        = string
}
