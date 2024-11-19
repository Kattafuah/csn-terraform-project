execution_role_arn = "arn:aws:iam::493475752675:role/ecsTaskExecutionRole" # Replace with your actual IAM Role ARN
route53_zone_id = "Z0409119JJPH7TF04AWF"     # Replace with your actual Route 53 zone ID
hosted_zone_id = "Z0409119JJPH7TF04AWF"
domain_name = "ingkwasiattafua.com"             # Replace with your actual domain name
rds_identifier = "my-custom-rds"
instance_class                      = "db.t3.micro"  # or your desired instance class
iam_database_authentication_enabled = false          # or true if you want it enabled
