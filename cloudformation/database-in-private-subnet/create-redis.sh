# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name redis \
  --template-body file://redis.yml \
  --parameters \
      ParameterKey=NetworkStackName,ParameterValue=rds-network \
      ParameterKey=CacheInstanceClass,ParameterValue=cache.t3.medium
