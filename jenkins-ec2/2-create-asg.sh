# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name jenkins-asg \
  --template-body file://jenkins-asg.yml \
  --capabilities CAPABILITY_IAM \
  --parameters \
      ParameterKey=StackName,ParameterValue=jenkins-network \
      ParameterKey=DesiredCapacity,ParameterValue=1 \
      ParameterKey=MaxSize,ParameterValue=2 \
      ParameterKey=InstanceType,ParameterValue=t2.micro 

aws cloudformation wait stack-create-complete --stack-name jenkins-asg
