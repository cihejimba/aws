data "aws_ssm_parameter" "alb_sg" {
  name = "${local.sec_grp_prefix}/alb_sg"
}

data "aws_ssm_parameter" "public_subnets" {
  name = local.public_subnets
}


resource "aws_lb" "alb" {
  name = "public-alb"
  internal = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.alb_sg.value]
  subnets            = split(",", data.aws_ssm_parameter.public_subnets.value)
}
