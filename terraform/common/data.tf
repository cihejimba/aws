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

data "aws_ssm_parameter" "security_groups" {
  count = length(local.sec_grp_names)
  name = "${local.sec_grp_prefix}/${local.sec_grp_names[count.index]}"
}
