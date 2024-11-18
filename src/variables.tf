variable "vpc_id" {
  description = "The ID of the VPC created in the VPC module."
  type        = string
}

variable "cluster_name" {
  description = "The name of the ECS cluster."
  type        = string
  default     = "csntp_cluster"
}

variable "execution_role_arn" {
  description = "The ARN of the IAM role that ECS tasks will use (obfuscated)."
  type        = string
}

variable "db_password" {
  description = "The database password generated by the security module and stored in Parameter Store."
  type        = string
}

variable "route53_zone_id" {
  description = "Zone ID of Route 53 domain"
  type        = string
}

variable "domain_name" {
  description = "Domain name"
  type        = string
}

