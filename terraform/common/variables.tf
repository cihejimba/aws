locals {
  tf_tag = { Terraform = "true" }
  env_tag = merge(local.tf_tag, { Environment = var.env })
  ec2_tag = merge(local.env_tag, { "Patch Group" = "al2-${var.env}" })

  # For SSM
  vpc_id = "/${var.env}/terraform/vpc/vpc_id"
  azs = "/${var.env}/terraform/vpc/azs"
  public_subnets = "/${var.env}/terraform/vpc/public_subnets"
  private_subnets = "/${var.env}/terraform/vpc/private_subnets"
  sec_grp_prefix = "/${var.env}/terraform/security_group"
  sec_grp_names = ["webserver_sg","rds_sg","ec_sg","alb_sg","ecstask_sg"] # if add new sg => update network/override.tf too
}

variable env {
  default = "dev"
}
