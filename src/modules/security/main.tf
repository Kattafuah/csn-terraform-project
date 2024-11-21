resource "aws_security_group" "rds_security_group" {
  name        = "rds_security_group"
  description = "security group for rds"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.web_ports[0]
    protocol        = "TCP"
    to_port         = var.web_ports[0]
    security_groups = [aws_security_group.ecs_security_group.id]
    description     = "Allow traffic from the ecs"
  }
}

resource "aws_security_group" "ecs_security_group" {
  name        = "ecs_security_group"
  description = "security group for ecs"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = var.web_ports[2]
    protocol        = "TCP"
    to_port         = var.web_ports[2]
    cidr_blocks     = ["0.0.0.0/0"]
    description     = "Allow traffic from the internet"
  }

  ingress {
    from_port       = var.web_ports[2]
    protocol        = "TCP"
    to_port         = var.web_ports[2]
    security_groups = [aws_security_group.elb_security_group.id]
    description     = "Allow traffic from elb"
  }


   ingress {
    from_port       = var.web_ports[3]
    protocol        = "TCP"
    to_port         = var.web_ports[3]
    security_groups = [aws_security_group.elb_security_group.id]
    description     = "Allow traffic from elb"
  }

  ingress {
    from_port       = var.web_ports[3]
    protocol        = "TCP"
    to_port         = var.web_ports[3]
    cidr_blocks     = ["0.0.0.0/0"]
    description     = "Allow traffic from the internet"
  }
 
  egress {
    from_port   = var.web_ports[0]
    protocol    = "TCP"
    to_port     = var.web_ports[0]
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = var.web_ports[1]
    protocol    = "TCP"
    to_port     = var.web_ports[1]
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = var.web_ports[2]
    protocol    = "TCP"
    to_port     = var.web_ports[2]
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = var.web_ports[3]
    protocol    = "TCP"
    to_port     = var.web_ports[3]
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "efs_security_group" {
  name        = "efs_sg"
  description = "route traffic to ecs security group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.web_ports[1]
    protocol    = "TCP"
    to_port     = var.web_ports[1]
    security_groups = [aws_security_group.ecs_security_group.id]
    description = "Allow traffic from ecs"
  }
}

resource "aws_security_group" "elb_security_group" {
  name        = "elb_sg1"
  description = "route traffic to ecs"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow web traffic to load balancer"
  }

  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

