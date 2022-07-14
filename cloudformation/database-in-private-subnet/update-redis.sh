# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation update-stack \
  --stack-name redis \
  --template-body file://redis.yml \
  --parameters \
      ParameterKey=NetworkStackName,ParameterValue=rds-network \
      ParameterKey=CacheNodeType,ParameterValue=cache.t3.medium	\
      ParameterKey=MultiAZSupport,ParameterValue=true \
      ParameterKey=NumCacheClusters,ParameterValue=2 \
      ParameterKey=SnapshotRetentionLimit,ParameterValue=7
