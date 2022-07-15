resource "aws_security_group" "demo_sg" {
  name = "samplesg"

  dynamic ingress {

    for_each = var.sg_ports
    iterator = port
    
    content {
      from_port = port.value
      to_port = port.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
