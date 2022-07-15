resource aws_instance myec2 {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  vpc_security_group_ids = ["sg-0b925e1c0ba97259f", "sg-02f0fc34"]
  key_name = "KeyPair-us-east-1"
  subnet_id = "subnet-0eb446c691b1b0f70"
  
  tags = {
    Name = "manual"
  }
}
