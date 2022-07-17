locals {
  common_tags = {
    Terraform = "true"
    Environment = var.env
    "Patch Group" = "al2-${var.env}"
  }

  # For SSM
  vpc_id = "/${var.env}/terraform/vpc/vpc_id"
  azs = "/${var.env}/terraform/vpc/azs"
  public_subnets = "/${var.env}/terraform/vpc/public_subnets"
  private_subnets = "/${var.env}/terraform/vpc/private_subnets"
  sec_grp_prefix = "/${var.env}/terraform/security_group"
  sec_grp_names = ["webserver_sg","rds_sg","ec_sg"]
  sec_grp_ids = [aws_security_group.webserver_sg.id, aws_security_group.rds_sg.id,aws_security_group.ec_sg.id]
}

variable env {
  default = "dev"
}
