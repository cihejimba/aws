# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation update-stack \
  --stack-name rds-database \
  --template-body file://database.yml \
  --parameters \
      ParameterKey=NetworkStackName,ParameterValue=rds-network \
      ParameterKey=DBInstanceClass,ParameterValue=db.t3.medium \
      ParameterKey=DBName,ParameterValue=MyDatabase \
      ParameterKey=DBUsername,ParameterValue=dbroot
