resource "aws_security_group" "mysg" {
  name = "mysg"

  ingress {
    description = "http"
    from_port = local.port
    to_port = local.port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

locals {
  port = 80
}

output sg_id {
  value = aws_security_group.mysg.id
}



