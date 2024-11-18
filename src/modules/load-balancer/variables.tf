variable "target_group_name" {
  type    = string
  default = "csntp-alb-group"
}

variable "elb_name" {
  type    = string
  default = "csntp-alb"
}


variable "elb_type" {
  default = "application"
  type    = string
}


variable "certificate_arn" {
  type    = string
  default = "arn:aws:acm:us-east-1:493475752675:certificate/ed6c4ade-8ddd-46c5-b7d3-0eb020d7fe1f"
}

variable "listener_forward_type" {
  default = "forward"
}