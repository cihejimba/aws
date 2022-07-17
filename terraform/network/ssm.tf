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
/*
resource "aws_ssm_parameter" "security_groups" {

  count = length(aws_security_group.security_groups)
  
  name  = "${local.prefix_security_groups}/${aws_security_group.security_groups[count.index].name}"
  type  = "String"
  value = aws_security_group.security_groups[count.index].id

  tags = local.common_tags
}
*/

