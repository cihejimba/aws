data "aws_ssm_parameter" "alb_sg" {
  name = "${local.sec_grp_prefix}/alb_sg"
}

data "aws_ssm_parameter" "public_subnets" {
  name = local.public_subnets
}

data "aws_ssm_parameter" "vpc_id" {
  name = local.vpc_id
}


resource "aws_lb" "alb" {
  name = "public-alb"
  internal = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.alb_sg.value]
  subnets            = split(",", data.aws_ssm_parameter.public_subnets.value)
}

resource "aws_lb_target_group" "ecs_tg" {
  name        = "tg-to-${var.service_name}"
  
  port        = var.container_port
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = data.aws_ssm_parameter.vpc_id.value

  health_check {
    interval = var.health_check_interval
    path = var.health_check_path
    protocol = "HTTP"
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 2    
    matcher = "200"  # has to be HTTP 200 or fails
  }
  
}
