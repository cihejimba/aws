resource "aws_ssm_parameter" "vpc_id" {
  name  = local.vpc_id
  type  = "String"
  value = module.vpc.vpc_id

  tags = local.env_tag
}

resource "aws_ssm_parameter" "azs" {
  name  = local.azs
  type  = "StringList"
  value = join(",",module.vpc.azs)

  tags = local.env_tag
}

resource "aws_ssm_parameter" "public_subnets" {
  name  = local.public_subnets
  type  = "StringList"
  value = join(",",module.vpc.public_subnets)

  tags = local.env_tag
}

resource "aws_ssm_parameter" "private_subnets" {
  name  = local.private_subnets
  type  = "StringList"
  value = join(",",module.vpc.private_subnets)

  tags = local.env_tag
}

resource "aws_ssm_parameter" "security_groups" {
  count = length(local.sec_grp_names)
  name  = "${local.sec_grp_prefix}/${local.sec_grp_names[count.index]}"
  type  = "String"
  value = "${local.sec_grp_ids[count.index]}" 

  tags = local.env_tag
}
