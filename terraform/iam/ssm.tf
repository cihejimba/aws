resource "aws_ssm_parameter" "iam_roles" {
  count = length(local.iam_role_names)
  name  = "${local.iam_role_prefix}/${local.iam_role_names[count.index]}"
  type  = "String"
  value = "${local.iam_role_arns[count.index]}" 

  tags = local.env_tag
}
