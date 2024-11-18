variable "rds_identifier" {
  type    = string
  default = "csntp"
}

variable "rds_db_name" {
  type    = string
  default = "csntp_db"
}

variable "database_username" {
  type    = string
  default = "admin"
}

variable "instance_class" {
  default = "db.t3.micro"
}

variable "iam_database_authentication_enabled" {
  default = false
}

variable "aws_efs_access_point" {
  type    = string
  default = "csntp_efs_access_point"
}

variable "pub_access" {
  type    = bool
  default = false
}