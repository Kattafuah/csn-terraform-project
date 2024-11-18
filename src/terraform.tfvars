execution_role_arn = "arn:aws:iam::493475752675:role/ecsTaskExecutionRole" # Replace with your actual IAM Role ARN
route53_zone_id = "Z0409119JJPH7TF04AWF"     # Replace with your actual Route 53 zone ID
domain_name = "ingkwasiattafua.com"             # Replace with your actual domain name
vpc_id = module.vpc.vpc_id # Assuming 'vpc_id' is an output from the 'vpc' module
db_password = module.rds.aws_ssm_parameter.database_password # Assuming 'generated_db_password' is an output from the 'security' module
