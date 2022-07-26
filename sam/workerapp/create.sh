#!/bin/sh

REGION=us-east-1
KEYPAIR=$(aws ec2 describe-key-pairs | jq -r '.KeyPairs[0].KeyName')
eb init --keyname $KEYPAIR --region $REGION -p ruby-2.7 workerapp
eb create --region $REGION --tier worker workerapp-dev

aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess --role-name aws-elasticbeanstalk-ec2-role
aws iam attach-role-policy --policy-arn arn:aws:iam::aws:policy/TranslateReadOnly --role-name aws-elasticbeanstalk-ec2-role
