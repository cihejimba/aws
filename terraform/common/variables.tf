locals {
  provider_tag = { Terraform = "true" } # provider default tag
  env_tag = { Environment = var.env } # will be merged with provider default tag
  ec2_tag = merge(local.env_tag, { "Patch Group" = "al2-${var.env}" })

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
}

variable env {
  default = "dev"
}

### ECS ###
variable cluster_name {
  description = "A human-readable name for the cluster."
  default = "ecs-cluster"
}

variable service_name {
  description = "A human-readable name for the service."
  default = "ecs-service"
}

variable container_cpu {
  description = "How much CPU to give the container. 1024 is 1 CPU."
  default = 256
}

variable container_memory {
  description = "How much memory in megabytes to give the container."
  default = 512
}

variable desired_count {
  description = "How many copies of the service task to run."
  default = 2
}

variable image_url {
  description = "The url of a docker image that will handle incoming traffic."
  default = "hello-world"
}
### ECS ###
