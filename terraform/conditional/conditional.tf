provider "aws" {
  region = "us-east-1"
}

variable "istest" {}

resource "aws_instance" "dev" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.micro"
  count = var.istest == true ? 1 : 0
}

resource "aws_instance" "prod" {
  ami = "ami-0022f774911c1d690"
  instance_type = "t2.large"
  count = var.istest == true ? 0 : 1
}
