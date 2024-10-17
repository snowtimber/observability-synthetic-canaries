#!/bin/bash

# Observability Synthetic Canaries Deployment Script
# This script deploys the CloudFormation stack for Synthetic Canaries

# ====================================
# Initial Setup Instructions
# ====================================

# 1. Install AWS CLI:
#    - For macOS: brew install awscli
#    - For Windows: https://awscli.amazonaws.com/AWSCLIV2.msi
#    - For Linux: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

# 2. Create an IAM User:
#    a. Go to AWS Console > IAM > Users > Add user
#    b. Set user name and enable "Programmatic access"
#    c. Attach policies: AWSCloudFormationFullAccess, IAMFullAccess, AmazonS3FullAccess, CloudWatchFullAccess
#    d. Complete user creation and save the Access Key ID and Secret Access Key

# 3. Configure AWS CLI:
#    Run: aws configure
#    Enter your Access Key ID, Secret Access Key, default region (e.g., us-east-1), and output format (json)

# 4. Install AWS SAM CLI:
#    Follow instructions at: https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html

# ====================================
# Deployment Configuration
# ====================================

STACK_NAME="observability-synthetic-canaries"
REGION="us-east-1"  # Change this to your preferred region

# ====================================
# Deployment Process
# ====================================

echo "Starting deployment of $STACK_NAME in $REGION"

# Validate the template
echo "Validating CloudFormation template..."
aws cloudformation validate-template --template-body file://template.yaml --region $REGION

if [ $? -ne 0 ]; then
    echo "Template validation failed. Please check your template for errors."
    exit 1
fi

# Deploy the stack
echo "Deploying CloudFormation stack..."
aws cloudformation deploy \
    --template-file template.yaml \
    --stack-name $STACK_NAME \
    --capabilities CAPABILITY_IAM \
    --region $REGION

if [ $? -eq 0 ]; then
    echo "Deployment successful!"
    echo "You can view your stack in the AWS CloudFormation console:"
    echo "https://$REGION.console.aws.amazon.com/cloudformation/home?region=$REGION#/stacks"
else
    echo "Deployment failed. Check the AWS CloudFormation console for error details."
    exit 1
fi

# ====================================
# Post-Deployment Instructions
# ====================================

echo "
Post-Deployment Steps:
1. Go to AWS CloudWatch console to view your Synthetic Canaries:
   https://$REGION.console.aws.amazon.com/cloudwatch/home?region=$REGION#synthetics:canary/list

2. Check the CloudWatch Dashboard for canary metrics:
   https://$REGION.console.aws.amazon.com/cloudwatch/home?region=$REGION#dashboards:

3. To make changes, edit the template.yaml file and re-run this script.

4. To delete the stack, run:
   aws cloudformation delete-stack --stack-name $STACK_NAME --region $REGION
"