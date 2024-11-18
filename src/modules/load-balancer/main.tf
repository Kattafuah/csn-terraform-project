
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
  security_groups    = [aws_security_group.elb_security_group.id]
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

output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}
