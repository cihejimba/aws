provider "aws" {
  region = "us-east-1"
}


module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "single-instance"
  ami                    = "ami-0022f774911c1d690"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-0eb446c691b1b0f70"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
