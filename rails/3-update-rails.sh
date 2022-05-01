# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation update-stack \
  --stack-name rails-service \
  --template-body file://rails-service.yml \
  --capabilities CAPABILITY_IAM \
  --parameters \
      ParameterKey=StackName,ParameterValue=rails-network \
      ParameterKey=ServiceName,ParameterValue=rails \
      ParameterKey=ImageUrl,ParameterValue=yeasy/simple-web:latest \
      ParameterKey=ContainerPort,ParameterValue=80 \
      ParameterKey=HealthCheckPath,ParameterValue=/ \
      ParameterKey=HealthCheckIntervalSeconds,ParameterValue=90 \
      ParameterKey=DesiredCount,ParameterValue=1 \
      ParameterKey=ContainerCpu,ParameterValue=256 \
      ParameterKey=ContainerMemory,ParameterValue=256 \
      ParameterKey=KeyName,ParameterValue=KeyPair-us-east-1

#aws cloudformation wait stack-create-complete --stack-name rails-service
