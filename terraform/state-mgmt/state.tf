/*
resource aws_instance myec2 {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro" 
}
*/

resource aws_security_group demosg {
  name = "demosg"
  
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource aws_iam_user myuser {
  name = "myuser"
  path = "/system/"
}

