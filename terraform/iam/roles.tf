data "aws_iam_policy_document" "ecs_tasks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

/*
resource "aws_iam_policy" "ecs_agent_policy" {
  name = "ecs-agent-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
	Action   = [
	  "ecr:GetAuthorizationToken",
	  "ecr:BatchCheckLayerAvailability",
	  "ecr:GetDownloadUrlForLayer",
	  "ecr:BatchGetImage",
	  "logs:CreateLogStream",
	  "logs:PutLogEvents"
	]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  }) 
}
*/

# ecs agent role aka execution role
resource "aws_iam_role" "ecs_agent_role" {
  name = "ecs-agent-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"]
}

# ecs task role
resource "aws_iam_role" "ecs_task_role" {
  name = "ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
}
