# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name jenkins-service \
  --template-body file://jenkins-service-efs.yml \
  --capabilities CAPABILITY_IAM \
  --parameters \
      ParameterKey=StackName,ParameterValue=jenkins-network \
      ParameterKey=ServiceName,ParameterValue=jenkins \
      ParameterKey=ImageUrl,ParameterValue=jenkins/jenkins:lts-jdk11 \
      ParameterKey=ContainerPort,ParameterValue=8080 \
      ParameterKey=HealthCheckPath,ParameterValue=/login \
      ParameterKey=HealthCheckIntervalSeconds,ParameterValue=90 \
      ParameterKey=DesiredCount,ParameterValue=1 \
      ParameterKey=ContainerCpu,ParameterValue=512 \
      ParameterKey=ContainerMemory,ParameterValue=1024 \
      ParameterKey=VolumeName,ParameterValue=jenkins-volume \
      ParameterKey=MountPoint,ParameterValue=jenkins-mountpoint 

#aws cloudformation wait stack-create-complete --stack-name jenkins-service
