provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "csn-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
