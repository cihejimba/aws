data "aws_iam_policy_document" "ecs-tasks-assume-role-policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "ecs-task-policy" {
  name = "ecs-task-policy"

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

  #tags = local.tf_tag
}

# ecs task role to define in task definition
resource "aws_iam_role" "ecstask_role" {
  name = "ecstask_role"
  #path = "/system/"
  assume_role_policy = data.aws_iam_policy_document.ecs-tasks-assume-role-policy.json
  managed_policy_arns = [aws_iam_policy.ecs-task-policy.arn]

  #tags = local.tf_tag
}
