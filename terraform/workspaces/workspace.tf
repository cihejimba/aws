provider aws {
  region = "us-east-1"
}

resource aws_instance myec2 {
  ami = "ami-0022f774911c1d690"
  instance_type = lookup(var.itype, terraform.workspace)
}

variable itype {
  type = map
  
  default = {
    default = "t2.nano"
    dev = "t2.micro"
    prod = "t2.large"
  }
}
