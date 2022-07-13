# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name rds-network \
  --template-body file://network.yml \
  --capabilities CAPABILITY_IAM
