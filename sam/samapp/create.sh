#!/bin/sh

sam build || exit 1
sam deploy --no-confirm-changeset --parameter-overrides \
	ParameterKey=QueueName,ParameterValue=SAMAppQueue || exit 1
