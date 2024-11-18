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