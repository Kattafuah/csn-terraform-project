provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "csn-terraform-state"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.terraform_state.bucket
}
