locals {
  container_definitions = jsonencode([
    {
      name      = var.service_name
      image     = var.image_url
      cpu       = var.container_cpu
      memory    = var.container_memory
      essential = true
      portMappings = [
	{
	  containerPort = var.container_port
	  #hostPort      = var.container_port
	}
      ]
      logConfiguration = {
	logDriver = "awslogs"
	options = {
	  awslogs-group = var.service_name
	  awslogs-region = local.region
	  awslogs-stream-prefix = var.service_name
	}
      }
      
    } 
  ])
}


resource "aws_ecs_task_definition" "app" {
  family                   = var.service_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.container_cpu
  memory                   = var.container_memory
  execution_role_arn       = data.aws_ssm_parameter.ecs_agent_role.value
  task_role_arn            = data.aws_ssm_parameter.ecs_task_role.value
  container_definitions    = local.container_definitions
}
