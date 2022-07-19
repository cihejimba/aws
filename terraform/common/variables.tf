data "aws_region" "current" {}

locals {
  provider_tag = { Terraform = "true" } # provider default tag
  env_tag = { Environment = var.env } # will be merged with provider default tag
  ec2_tag = merge(local.env_tag, { "Patch Group" = "al2-${var.env}" })

  region = data.aws_region.current.name
  
  # For SSM
  vpc_id = "/${var.env}/terraform/vpc/vpc_id"
  azs = "/${var.env}/terraform/vpc/azs"
  public_subnets = "/${var.env}/terraform/vpc/public_subnets"
  private_subnets = "/${var.env}/terraform/vpc/private_subnets"
  sec_grp_prefix = "/${var.env}/terraform/security_group"
  sec_grp_names = ["webserver_sg","rds_sg","ec_sg","alb_sg","ecstask_sg"] # if add new sg => update network/ssm.tf too

  # For IAM
  iam_role_prefix = "/${var.env}/terraform/iam_role"
  iam_role_names = ["ecs_agent_role","ecs_task_role"] # update iam/ssm.tf too

  # For ECS
  awslogs_group = "/aws/ecs/${var.service_name}"
  awslogs_stream_prefix = "env=${var.env} image_url=${var.image_url} "

  # ECS AS
  min_capacity = 1
  max_capacity = 10
}

variable env {
  default = "dev"
}

### ECS ###
variable cluster_name {
  description = "A human-readable name for the cluster."
  default = "webapp-cluster"
}

variable service_name {
  description = "A human-readable name for the service."
  default = "webapp"
}

variable container_cpu {
  description = "How much CPU to give the container. 1024 is 1 CPU."
  default = 256
}

variable container_memory {
  description = "How much memory in megabytes to give the container."
  default = 512
}

variable container_port {
  description = "The port number the application inside the docker container"
  default = 80
}

variable desired_count {
  description = "How many copies of the service task to run."
  default = 2
}

variable image_url {
  description = "The url of a docker image that will handle incoming traffic."
  default = "nginxdemos/hello"
}

### ALB ###
variable health_check_interval {
  description = "Number of seconds to wait between each health check."
  default = 90
}

variable health_check_path {
  description = "Path to perform the healthcheck on each instance."
  default = "/"
}

variable alb_path {
  description = "A path on the public load balancer that this service should be connected to."
  default = "*"
}


