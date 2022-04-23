# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name demo-ecs-zero-downtime-deployment-network \
  --template-body file://network.yml \
  --capabilities CAPABILITY_IAM

aws cloudformation wait stack-create-complete --stack-name demo-ecs-zero-downtime-deployment-network

aws cloudformation create-stack \
  --stack-name demo-ecs-zero-downtime-deployment-service \
  --template-body file://service.yml \
  --parameters \
      ParameterKey=StackName,ParameterValue=demo-ecs-zero-downtime-deployment-network \
      ParameterKey=ServiceName,ParameterValue=webapp \
      ParameterKey=ImageUrl,ParameterValue=199603965279.dkr.ecr.us-east-1.amazonaws.com/webapp:latest \
      ParameterKey=ContainerPort,ParameterValue=80 \
      ParameterKey=HealthCheckPath,ParameterValue=/health.html \
      ParameterKey=HealthCheckIntervalSeconds,ParameterValue=90

aws cloudformation wait stack-create-complete --stack-name demo-ecs-zero-downtime-deployment-service
