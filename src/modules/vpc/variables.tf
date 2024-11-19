variable "region" {
  default = "us-east-1"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "vpc_name" {
  default = "csntp_vpc"
}

variable "subnetnames" {
  default = ["wp_pri_sn1", "wp_pub_sn1", "wp_pub_sn2", "wp_pri_sn2"]
  type    = list(any)
}

variable "subnet1_cidr" {
  default = "10.0.1.0/24"
}

variable "subnet2_cidr" {
  default = "10.0.2.0/24"
}

variable "subnet3_cidr" {
  default = "10.0.3.0/24"
}

variable "subnet4_cidr" {
  default = "10.0.4.0/24"
}

variable "az" {
  default = ["us-east-1a", "us-east-1b"]
  type    = list(any)
}

variable "internet_gateway_name" {
  default = "csntp_igw"
}


variable "pub_access" {
  type    = bool
  default = false
}


variable "nat-gw-ip" {
  default = "10.0.0.5"
}

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

variable "route53_zone_id" {
  type = string
}

variable "alb_dns_name" {
  type = string
}

variable "hosted_zone_id" {
    type    = string
}