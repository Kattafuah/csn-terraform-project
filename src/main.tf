module "vpc" {
  source = "./modules/vpc"
}

module "security" {
  source = "./modules/security"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source               = "./modules/rds"
  # subnets              = module.vpc.pri_subnets
  # rds_security_group_id = module.security.rds_security_group_id
  database_username          = module.rds.aws_ssm_parameter.database_username
  # db_password          = module.rds.aws_ssm_parameter.database_password.value
  # vpc_id               = module.vpc.vpc_id
}


module "load-balancer" {
  source               = "./modules/load-balancer"
  # subnets              = module.vpc.public_subnets
  # lb_security_group_id = module.security.lb_security_group_id
  # vpc_id               = var.vpc_id
  # certificate_arn      = module.domain-ssl.certificate_arn
}


module "ecs-fargate" {
  source                      = "./modules/ecs-fargate"
  # cluster_name                = var.cluster_name
  # subnets                     = module.vpc.public_subnets
  # security_group_id           = module.security.ecs_security_group_id
  execution_role_arn          = var.execution_role_arn
  ssm_db_host_param           = module.rds.ssm_db_host_param
  ssm_db_user_param           = module.rds.ssm_db_user_param
  secrets_manager_db_password = module.rds.aws_ssm_parameter.database_password
}

module "domain-ssl" {
  source          = "./modules/domain-ssl"
  route53_zone_id = "Z0409119JJPH7TF04AWF"
  hosted_zone_id = "Z0409119JJPH7TF04AWF"
  alb_dns_name    = module.load-balancer.alb_dns_name
  # name     = var.domain_name
}


resource "aws_something_else" "example_usage" {
  vpc_id      = module.vpc.vpc_id  # Correct use of a module output in main.tf
  db_password = module.aws_ssm_parameter.database_password # Correct use of a module output in main.tf
}