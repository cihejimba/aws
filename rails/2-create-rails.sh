# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name rails-service \
  --template-body file://rails-service.yml \
  --capabilities CAPABILITY_IAM \
  --parameters \
      ParameterKey=StackName,ParameterValue=rails-network \
      ParameterKey=ServiceName,ParameterValue=rails \
      ParameterKey=ImageUrl,ParameterValue=docker.io/bitnami/rails:7 \
      ParameterKey=ContainerPort,ParameterValue=3000 \
      ParameterKey=HealthCheckPath,ParameterValue=/ \
      ParameterKey=HealthCheckIntervalSeconds,ParameterValue=90 \
      ParameterKey=DesiredCount,ParameterValue=1 \
      ParameterKey=ContainerCpu,ParameterValue=512 \
      ParameterKey=ContainerMemory,ParameterValue=1024 \

aws cloudformation wait stack-create-complete --stack-name rails-service
