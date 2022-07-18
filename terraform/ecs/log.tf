resource "aws_cloudwatch_log_group" "ecs_service" {
  name = var.service_name
  retention_in_days = 1
  tags = local.env_tag
}
