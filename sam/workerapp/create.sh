#!/bin/sh

REGION=us-east-1
KEYPAIR=$(aws ec2 describe-key-pairs | jq -r '.KeyPairs[0].KeyName')
eb init --keyname $KEYPAIR --region $REGION -p ruby-3.0 workerapp
eb create --region $REGION workerapp-dev

