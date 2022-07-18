data "aws_ssm_parameter" "alb_sg" {
  name = "${local.sec_grp_prefix}/alb_sg"
}

data "aws_ssm_parameter" "public_subnets" {
  name = local.public_subnets
}

data "aws_ssm_parameter" "vpc_id" {
  name = local.vpc_id
}


resource "aws_lb" "front_end" {
  name = "public-alb"
  internal = false
  load_balancer_type = "application"
  security_groups    = [data.aws_ssm_parameter.alb_sg.value]
  subnets            = split(",", data.aws_ssm_parameter.public_subnets.value)
}

resource "aws_lb_target_group" "front_end" {
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

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.front_end.arn
  #port              = "8080"
  #protocol          = "HTTP"

  default_action {
    type             = "forward"
    #target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_listener_rule" "host_based_routing" {
  listener_arn = aws_lb_listener.front_end.arn
  priority = 1
  
  action {
    type = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }

  condition {
    path_pattern {
      values = [var.alb_path]
    }
  }
}



