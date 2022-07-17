# Declare the data source
data "aws_availability_zones" "available" {
  state = "available"
}

# https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-tf-vpc"
  cidr = "10.0.0.0/16"

  #azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  azs = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_dns_hostnames = true
  enable_dns_support = true
  
  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = local.common_tags
}
