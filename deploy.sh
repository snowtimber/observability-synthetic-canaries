#!/bin/bash
# This script deploys the CloudFormation stack
# Usage:
# chmod +x deploy.sh
# ./deploy.sh


STACK_NAME="observability-synthetic-canaries"
REGION="us-east-1"  # or any region where you want to deploy the canary

aws cloudformation deploy \
    --template-file template.yaml \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_IAM \
    --region $REGION