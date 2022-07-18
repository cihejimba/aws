resource "aws_ecs_service" "app" {
  name                = var.service_name
  cluster             = aws_ecs_cluster.ecs_cluster.id
  launch_type         = "FARGATE"
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  desired_count = var.desired_count
  health_check_grace_period_seconds = 600

  # awsvpc only
  network_configuration {
    assign_public_ip = true
    security_groups = [data.aws_ssm_parameter.ecstask_sg.value]
    subnets = split(",", data.aws_ssm_parameter.public_subnets.value)
  }
  
  task_definition     = aws_ecs_task_definition.app.arn

  load_balancer {
    target_group_arn = aws_lb_target_group.front_end.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }

  tags = local.env_tag
}
