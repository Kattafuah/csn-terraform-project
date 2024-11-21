resource "aws_vpc" "csntp" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "pub_sn1" {
  vpc_id            = aws_vpc.csntp.id
  cidr_block        = var.subnet1_cidr
  availability_zone = var.az[0]
  tags = {
    Name = var.subnetnames[1]
  }
}

resource "aws_subnet" "pub_sn2" {
  vpc_id            = aws_vpc.csntp.id
  cidr_block        = var.subnet3_cidr
  availability_zone = var.az[1]
  tags = {
    Name = var.subnetnames[2]
  }
}

resource "aws_subnet" "pri_sn1" {
  vpc_id            = aws_vpc.csntp.id
  cidr_block        = var.subnet4_cidr
  availability_zone = var.az[0]
  tags = {
    Name = var.subnetnames[0]
  }
}

resource "aws_subnet" "pri_sn2" {
  vpc_id            = aws_vpc.csntp.id
  cidr_block        = var.subnet2_cidr
  availability_zone = var.az[1]
  tags = {
    Name = var.subnetnames[3]
  }
}

resource "aws_route_table" "pri-route-table" {
  vpc_id = aws_vpc.csntp.id
  tags = {
    Name = "wp-pri-route-table"
  }
}

resource "aws_route_table" "pub-route-table" {
  vpc_id = aws_vpc.csntp.id
  tags = {
    Name = "wp-pub-route-table"
  }
}

resource "aws_route_table_association" "pub_sn1_association" {
  subnet_id      = aws_subnet.pub_sn1.id
  route_table_id = aws_route_table.pub-route-table.id
}

resource "aws_route_table_association" "pub_sn2_association" {
  subnet_id      = aws_subnet.pub_sn2.id
  route_table_id = aws_route_table.pub-route-table.id
}

resource "aws_route_table_association" "pri_sn1_association" {
  subnet_id      = aws_subnet.pri_sn1.id
  route_table_id = aws_route_table.pri-route-table.id
}

resource "aws_route_table_association" "pri_sn2_association" {
  subnet_id      = aws_subnet.pri_sn2.id
  route_table_id = aws_route_table.pri-route-table.id
}

resource "aws_internet_gateway" "internet-gw" {
  vpc_id = aws_vpc.csntp.id

  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route" "pub-route-table-route-for-igw" {
  route_table_id         = aws_route_table.pub-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet-gw.id
}


/*resource "aws_eip" "eip-for-nat-gw" {
  associate_with_pri_ip = var.nat-gw-ip
  tags = {
    Name = "csntp-eip"
  }
}

resource "aws_nat_gateway" "csntp-nat-gw" {
  allocation_id = aws_eip.eip-for-nat-gw.id
  subnet_id     = aws_subnet.pub_sn1.id

  tags = {
    Name = "csntp-nat-gw"
  }

}

resource "aws_route" "pri-route-table-route-for-nat-gw" {
  route_table_id         = aws_route_table.pri-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_nat_gateway.csntp-nat-gw.id
}*/


resource "aws_db_subnet_group" "csntp_subnet_group" {
  name       = "csntp_subnet_group"
  subnet_ids = [aws_subnet.pri_sn1.id, aws_subnet.pri_sn2.id]
                 
  tags = {
    Name = "csntp subnet group"
  }
}


resource "aws_lb_target_group" "csntp_target_group" {
  name        = var.target_group_name
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.csntp.id

  health_check {
    path     = "/wp-admin/install.php"
    protocol = "HTTP"
  }
}


resource "aws_lb" "csntp_elb" {
  name               = var.elb_name
  internal           = false
  load_balancer_type = var.elb_type
  security_groups    = [module.security.elb_security_group]
  subnets            = [aws_subnet.pub_sn1.id, aws_subnet.pub_sn2.id]

  enable_deletion_protection = false

  tags = {
    Environment = "dev"
  }
}

resource "aws_lb_listener" "csntp_listener" {
  load_balancer_arn = aws_lb.csntp_elb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = var.listener_forward_type
    target_group_arn = aws_lb_target_group.csntp_target_group.arn
  }
}

resource "aws_lb_listener" "csntp_listener_SSL" {
  load_balancer_arn = aws_lb.csntp_elb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn

  default_action {
    type             = var.listener_forward_type
    target_group_arn = aws_lb_target_group.csntp_target_group.arn
  }
}

resource "aws_route53_record" "csntp_dns" {
  zone_id = var.hosted_zone_id
  allow_overwrite = true
  name    = "ingkwasiattafua.com"
  type    = "A"

  alias {
    name                   = aws_lb.csntp_elb.dns_name
    zone_id                = var.hosted_zone_id
    evaluate_target_health = true
  }
}

module "security" {
  source = "../security"  // Adjust the path based on your directory structure
  vpc_id = aws_vpc.csntp.id  // Ensure you have a VPC resource defined in this module
}
