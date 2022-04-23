# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation execute-change-set \
  --stack-name demo-ecs-zero-downtime-deployment-service \
  --change-set-name update-demo-ecs-zero-downtime-deployment-service

aws cloudformation wait stack-update-complete --stack-name demo-ecs-zero-downtime-deployment-service
