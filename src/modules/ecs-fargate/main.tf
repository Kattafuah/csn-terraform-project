resource "aws_ecs_cluster" "csntp_cluster" {
  name = "csntp_cluster"
}

resource "aws_ecs_cluster_capacity_providers" "csntp_cluster_capacity" {
  cluster_name = aws_ecs_cluster.csntp_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}

resource "aws_cloudwatch_log_group" "csntp_ecs_logs" {
  name = "/ecs/csntp_logs"

}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role1"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role" "ecs_task_role" {
  name = "ecs_task_role1"
 
  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
 
resource "aws_iam_role_policy_attachment" "ecs-task-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonElasticFileSystemClientFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs-task-execution-role-policy-attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

}

resource "aws_ecs_task_definition" "csntp_task_definition" {
  family                   = "csntp_family"
  task_role_arn            = aws_iam_role.ecs_task_role.arn
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = "1024"
  memory                   = "3072"
  requires_compatibilities = ["FARGATE"]
  
  container_definitions    = jsonencode([
    {
      name      = "wordpress",
      image     = "wordpress:php8.3-apache",
      cpu       = 1024,  # 1 vCPU = 1024 units
      memory    = 3072,  # 3 GB = 3072 MB
      essential = true,
      portMappings = [
        {
          containerPort = 80,
          hostPort      = 80
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-region        = "us-east-2",
          awslogs-group         = "/ecs/csntp_logs",
          awslogs-stream-prefix = "ecs",
          awslogs-create-group  = "true"                # Ensure the log group is created automatically if it doesn't exist
        }
      },
      environment = [
        {
          name  = "WORDPRESS_DB_HOST",
          value = module.rds.aws_db_instance.csntp_rds.endpoint
        },
        {
          name  = "WORDPRESS_DB_USER",
          value = module.rds.aws_ssm_parameter.database_username.value
        },
        {
          name  = "WORDPRESS_DB_PASSWORD",
          value = module.rds.aws_ssm_parameter.database_password.value
        },
        {
          name  = "WORDPRESS_DB_NAME",
          value = module.rds_db_name
        }
      ]
    }
  ])

  volume {
    name = "csntp_efs_volume"

    efs_volume_configuration {
      file_system_id          = aws_efs_file_system.csntp_efs.id
      root_directory          = "/"
      transit_encryption      = "ENABLED"
      transit_encryption_port = 2049
      authorization_config {
        access_point_id = aws_efs_access_point.csntp_access_pt.id
        iam             = "ENABLED"
      }
    }
  }
}

resource "aws_ecs_service" "csntp_service" {
  name            = var.ecs_service_name
  cluster         = aws_ecs_cluster.csntp_cluster.id
  task_definition = aws_ecs_task_definition.csntp_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  health_check_grace_period_seconds = 300

  network_configuration {
    subnets         = [aws_subnet.pub_sn1.id, aws_subnet.pub_sn2.id]
    security_groups = [aws_security_group.ecs_security_group.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.csntp_target_group.arn
    container_name   = "wordpress"
    container_port   = 80
  }
}