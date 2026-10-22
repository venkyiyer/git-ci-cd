
resource "aws_s3_bucket" "venky-first-bucket" {
    count = 2
    bucket = var.bucket-names[count.index]
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_instance" "venky-ec2-instance" {
    count = var.instance_count
    ami           = "resolve:ssm:/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
    instance_type = "t3.micro"
    tags = {
    Name = "${var.ec2_prefix}-venky-ec2-first-ec2"
    region = var.config.region
  }
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
#   vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_block[0]
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_private" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_block[1]
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_private_172" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = var.cidr_block[2]
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
