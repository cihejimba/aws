resource "aws_cloudwatch_log_group" "ecs_service" {
  name = local.awslogs_group
  retention_in_days = 30
  tags = local.env_tag
}
