data "aws_ssm_parameter" "vpc_id" {
  name = local.vpc_id
}

data "aws_ssm_parameter" "azs" {
  name = local.azs
}

data "aws_ssm_parameter" "public_subnets" {
  name = local.public_subnets
}

data "aws_ssm_parameter" "private_subnets" {
  name = local.private_subnets
}

data "aws_ssm_parameter" "webserver_sg" {
  name = "${local.sec_grp_prefix}/webserver_sg"
}

data "aws_ssm_parameter" "rds_sg" {
  name = "${local.sec_grp_prefix}/rds_sg"
}

data "aws_ssm_parameter" "ec_sg" {
  name = "${local.sec_grp_prefix}/ec_sg"
}
