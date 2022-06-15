provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


resource "aws_instance" "myec2" {
  ami = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
  key_name = "KeyPair-us-east-1"
  security_groups = [ "ssh" ]

  connection {
    type = "ssh"
    host = self.public_ip
    user = "ec2-user"
    private_key = "${file("/home/ec2-user/.ssh/KeyPair-us-east-1.pem")}"
  }

  
  provisioner remote-exec {
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl start httpd"
    ]
  }

  provisioner local-exec {
    when = destroy
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
  
}
