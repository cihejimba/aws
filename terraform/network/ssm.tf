resource "aws_ssm_parameter" "vpc_id" {
  name  = local.vpc_id
  type  = "String"
  value = module.vpc.vpc_id

  tags = local.common_tags
}

resource "aws_ssm_parameter" "azs" {
  name  = local.azs
  type  = "StringList"
  value = join(",",module.vpc.azs)

  tags = local.common_tags
}

resource "aws_ssm_parameter" "public_subnets" {
  name  = local.public_subnets
  type  = "StringList"
  value = join(",",module.vpc.public_subnets)

  tags = local.common_tags
}

resource "aws_ssm_parameter" "private_subnets" {
  name  = local.private_subnets
  type  = "StringList"
  value = join(",",module.vpc.private_subnets)

  tags = local.common_tags
}

resource "aws_ssm_parameter" "security_groups" {
  count = length(local.ssm_sec_grp_names)
  name  = "${local.security_group_prefix}/${local.ssm_sec_grp_names[count.index]}"
  type  = "String"
  value = "${local.ssm_sec_grp_ids[count.index]}" 

  tags = local.common_tags
}
