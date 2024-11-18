variable "vpc_id" {
  type = string
}

variable "database_username" {
  type    = string
  default = "admin"
}

variable "web_ports" {
  default = [3306, 2049, 80, 443]
  type    = list(any)
}