# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

IMAGE_URL=$1

aws cloudformation update-stack \
  --stack-name demo-ecs-zero-downtime-deployment-service \
  --use-previous-template \
  --parameters \
      ParameterKey=StackName,ParameterValue=demo-ecs-zero-downtime-deployment-network \
      ParameterKey=ServiceName,ParameterValue=webapp \
      ParameterKey=ImageUrl,ParameterValue=$IMAGE_URL \
      ParameterKey=ContainerPort,ParameterValue=80 \
      ParameterKey=HealthCheckPath,ParameterValue=/health.html \
      ParameterKey=HealthCheckIntervalSeconds,ParameterValue=90

aws cloudformation wait stack-update-complete --stack-name demo-ecs-zero-downtime-deployment-service
