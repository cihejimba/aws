# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-change-set \
  --change-set-name update-demo-ecs-zero-downtime-deployment-service \
  --stack-name demo-ecs-zero-downtime-deployment-service \
  --use-previous-template \
  --parameters \
      ParameterKey=StackName,ParameterValue=demo-ecs-zero-downtime-deployment-network \
      ParameterKey=ServiceName,ParameterValue=webapp \
      ParameterKey=ImageUrl,ParameterValue=199603965279.dkr.ecr.us-east-1.amazonaws.com/webapp:latest \
      ParameterKey=ContainerPort,ParameterValue=80 \
      ParameterKey=HealthCheckPath,ParameterValue=/health.html \
      ParameterKey=HealthCheckIntervalSeconds,ParameterValue=90

aws cloudformation describe-change-set \
  --stack-name demo-ecs-zero-downtime-deployment-service \
  --change-set-name update-demo-ecs-zero-downtime-deployment-service
