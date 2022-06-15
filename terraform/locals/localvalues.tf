provider "aws" {
  region = "us-east-1"
}

locals {
  common_tags = {
    Owner = "DevOps Team"
    service = "backend"
  }
}

resource "aws_instance" "dev" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  tags = local.common_tags
}
