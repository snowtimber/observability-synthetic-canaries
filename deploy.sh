#!/bin/bash

# usage: 
# chmod +x deploy.sh
# ./deploy.sh

# Load configuration
REGION=$(grep 'region:' config.yaml | awk '{print $2}')
STACK_NAME=$(grep 'stack_name:' config.yaml | awk '{print $2}')

echo "Starting deployment of $STACK_NAME in $REGION"

# Validate the template
echo "Validating SAM template..."
sam validate --template template.yaml

if [ $? -ne 0 ]; then
    echo "Template validation failed. Please check your template for errors."
    exit 1
fi

# Deploy the stack
echo "Deploying SAM stack..."
sam deploy \
    --template-file template.yaml \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
    --region $REGION \
    --guided

if [ $? -eq 0 ]; then
    echo "Deployment successful!"
    echo "You can view your stack in the AWS CloudFormation console:"
    echo "https://$REGION.console.aws.amazon.com/cloudformation/home?region=$REGION#/stacks"
else
    echo "Deployment failed. Check the AWS CloudFormation console for error details."
    exit 1
fi