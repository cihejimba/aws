#!/bin/bash
export AWS_DEFAULT_REGION=ap-northeast-1
aws ec2 describe-security-groups | jq '.SecurityGroups[] .GroupName'

