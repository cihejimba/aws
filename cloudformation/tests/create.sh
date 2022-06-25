# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name demo-param-store \
  --template-body file://param-store.yml \
  --parameters \
  ParameterKey=ApplicationElbSubnets,ParameterValue=good
