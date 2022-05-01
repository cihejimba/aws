# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation create-stack \
  --stack-name rails-database \
  --template-body file://rails-database.yml \
  --capabilities CAPABILITY_IAM \
  --parameters \
      ParameterKey=NetworkStackName,ParameterValue=rails-network \
      ParameterKey=DBName,ParameterValue=railsdb \
      ParameterKey=DBUsername,ParameterValue=railsadmin

