output "vpc_id" {
  value = aws_vpc.csntp.id
}

output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = aws_vpc.csntp.cidr_block
}

# Outputs for Public Subnets
output "public_subnet1_id" {
  description = "The ID of the first public subnet"
  value       = aws_subnet.pub_sn1.id
}

output "public_subnet1_cidr" {
  description = "The CIDR block of the first public subnet"
  value       = aws_subnet.pub_sn1.cidr_block
}

output "public_subnet2_id" {
  description = "The ID of the second public subnet"
  value       = aws_subnet.pub_sn2.id
}

output "public_subnet2_cidr" {
  description = "The CIDR block of the second public subnet"
  value       = aws_subnet.pub_sn2.cidr_block
}

# Outputs for Private Subnets
output "private_subnet1_id" {
  description = "The ID of the first private subnet"
  value       = aws_subnet.pri_sn1.id
}

output "private_subnet1_cidr" {
  description = "The CIDR block of the first private subnet"
  value       = aws_subnet.pri_sn1.cidr_block
}

output "private_subnet2_id" {
  description = "The ID of the second private subnet"
  value       = aws_subnet.pri_sn2.id
}

output "private_subnet2_cidr" {
  description = "The CIDR block of the second private subnet"
  value       = aws_subnet.pri_sn2.cidr_block
}

# Outputs for Route Tables
output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.pub-route-table.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.pri-route-table.id
}

# Outputs for Internet Gateway
output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.internet-gw.id
}

# Outputs for DB Subnet Group
output "db_subnet_group_id" {
  description = "The ID of the DB subnet group"
  value       = aws_db_subnet_group.csntp_subnet_group.id
}

output "db_subnet_group_name" {
  description = "The name of the DB subnet group"
  value       = aws_db_subnet_group.csntp_subnet_group.name
}

output "db_subnet_group_subnet_ids" {
  description = "The subnet IDs in the DB subnet group"
  value       = aws_db_subnet_group.csntp_subnet_group.subnet_ids
}

output "alb_dns_name" {
  value = aws_lb.csntp_elb.dns_name
}

output "target_group_arn" {
  description = "The ARN of the target group"
  value       = aws_lb_target_group.csntp_target_group.arn
}

output "target_group_name" {
  description = "The name of the target group"
  value       = aws_lb_target_group.csntp_target_group.name
}

output "target_group_port" {
  description = "The port of the target group"
  value       = aws_lb_target_group.csntp_target_group.port
}

output "target_group_health_check_path" {
  description = "The health check path of the target group"
  value       = aws_lb_target_group.csntp_target_group.health_check[0].path
}

output "target_group_health_check_protocol" {
  description = "The health check protocol of the target group"
  value       = aws_lb_target_group.csntp_target_group.health_check[0].protocol
}

output "zone_id" {
  description = "The zone ID of the load balancer"
  value       = aws_lb.csntp_elb.zone_id
}
