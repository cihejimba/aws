locals {
  common_tags = {
    Terraform = "true"
    Environment = var.env
    "Patch Group" = "al2-${var.env}"
  }

  vpc_id = "/${var.env}/terraform/vpc/vpc_id"
  azs = "/${var.env}/terraform/vpc/azs"
  public_subnets = "/${var.env}/terraform/vpc/public_subnets"
  private_subnets = "/${var.env}/terraform/vpc/private_subnets"
}

variable env {
  default = "dev"
}
