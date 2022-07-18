data "aws_ssm_parameter" "alb_sg" {
  name = "${local.sec_grp_prefix}/alb_sg"
}

data "aws_ssm_parameter" "public_subnets" {
  name = local.public_subnets
}

data "aws_ssm_parameter" "vpc_id" {
  name = local.vpc_id
}

data "aws_ssm_parameter" "ecstask_sg" {
  name = "${local.sec_grp_prefix}/ecstask_sg"
}

data "aws_ssm_parameter" "ecs_agent_role" {
  name = "${local.iam_role_prefix}/ecs_agent_role"
}

data "aws_ssm_parameter" "ecs_task_role" {
  name = "${local.iam_role_prefix}/ecs_task_role"
}
