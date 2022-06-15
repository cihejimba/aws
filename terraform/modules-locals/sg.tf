module myec2 {
  source = "./mod"
}

resource aws_instance myec2 {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  vpc_security_group_ids = [module.myec2.sg_id]
}
