# Turning off the AWS pager so that the CLI doesn't open an editor for each command result
export AWS_PAGER=""

aws cloudformation delete-stack --stack-name rails-service
aws cloudformation wait stack-delete-complete --stack-name rails-service

aws cloudformation delete-stack --stack-name rails-database
aws cloudformation wait stack-delete-complete --stack-name rails-database

aws cloudformation delete-stack --stack-name rails-network
aws cloudformation wait stack-delete-complete --stack-name rails-network
