resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Generate a Private Key and encode it as PEM.
resource "aws_key_pair" "key_pair" {
  key_name   = "tfkeypair"
  public_key = tls_private_key.key.public_key_openssh

  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ./tfkeypair.pem && chmod 600 ./tfkeypair.pem"
  }
}


data "aws_ami" "app_ami" {
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["amzn2-ami-kernel-*hvm*"] #amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2
  }
}


resource "aws_instance" "myec2" {
  ami = data.aws_ami.app_ami.id
  instance_type = "t2.micro"
  key_name = aws_key_pair.key_pair.id
  
  vpc_security_group_ids = [var.repli_instance_sg_id]
  subnet_id              = element(var.repli_instance_subnetids,0)

  #user_data = file("${path.root}/ec2-userdata.tpl")
  user_data = <<-EOT
#!/bin/bash
yum update -y
yum install -y postgresql

echo "export PGPASSWORD=${var.dst_db_password};psql --host=${var.dst_db_host} --port=${var.dst_db_port} --username=${var.dst_db_user} --dbname=${var.dst_db_name}" > /root/psql-dst.sh
chmod 755 /root/psql-dst.sh

echo "export PGPASSWORD=${var.db_password};psql --host=${var.db_host} --port=${var.db_port} --username=${var.db_user} --dbname=${var.db_name}" > /root/psql-src.sh
chmod 755 /root/psql-src.sh

EOT

  
  root_block_device {
    volume_size = 8
  }
  
  tags = {
    Name = "check-db-instance"
  }

}

