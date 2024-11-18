resource "aws_db_instance" "csntp_rds" {
  allocated_storage                   = 20
  identifier                          = var.rds_identifier
  db_name                             = var.rds_db_name
  engine                              = "mysql"
  engine_version                      = "8.0.35"
  instance_class                      = var.instance_class
  username                            = aws_ssm_parameter.database_username.value 
  password                            = aws_ssm_parameter.database_password.value
  port                                = "3306"
  storage_type                        = "gp3"
  db_subnet_group_name                = "csntp_subnet_group"
  vpc_security_group_ids              = [aws_security_group.rds_security_group.id]
  skip_final_snapshot                 = true
  iam_database_authentication_enabled = var.iam_database_authentication_enabled
  deletion_protection                 = false
  publicly_accessible                 = var.pub_access
}


resource "aws_efs_file_system" "csntp_efs" {
  encrypted      =  true
    tags = {
    Name = "csntp_efs"
  }
}

resource "aws_efs_mount_target" "csntp_efs_mt1" {
  file_system_id = aws_efs_file_system.csntp_efs.id
  subnet_id      = aws_subnet.pri_sn1.id
  security_groups = [ aws_security_group.efs_security_group.id ]
}

resource "aws_efs_mount_target" "csntp_efs_mt2" {
  file_system_id = aws_efs_file_system.csntp_efs.id
  subnet_id      = aws_subnet.pri_sn2.id
  security_groups = [ aws_security_group.efs_security_group.id ]
  }



resource "aws_efs_access_point" "csntp_access_pt" {
  file_system_id = aws_efs_file_system.csntp_efs.id

  tags = {
    name        = var.aws_efs_access_point
    description = "Allow access to EFS"
  }
}

resource "random_password" "password" {
  length           = 12
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_ssm_parameter" "database_password" {
  name = "${local.ssm_path_database}"
  type = "SecureString"
  value = random_password.password.result
}

resource "aws_ssm_parameter" "database_username" {
  name = "${local.ssm_path_database}/username"
  type = "String"
  value = var.database_username
}

output "rds_endpoint" {
  value = aws_db_instance.wordpress_db.endpoint
}