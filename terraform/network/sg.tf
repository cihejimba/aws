resource "aws_security_group" "webserver_sg" {
  name        = "webserver_sg"
  description = "Web Server Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "SSH access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.common_tags, {Name = "webserver_sg"})
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "RDS Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "Allow access to Web Server Security Group"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    security_groups = [aws_security_group.webserver_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.common_tags, {Name = "rds_sg"})
}

resource "aws_security_group" "ec_sg" {
  name        = "ec_sg"
  description = "ElastiCache Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description      = "Allow access to Web Server Security Group"
    protocol         = "tcp"
    from_port        = 6379
    to_port          = 6379
    security_groups = [aws_security_group.webserver_sg.id]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(local.common_tags, {Name = "ec_sg"})
}

