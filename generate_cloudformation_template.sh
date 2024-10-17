#!/bin/bash

# Generate CloudFormation template from SAM template locally

# usage: 
# chmod +x generate_cloudformation_template.sh
# ./generate_cloudformation_template.sh

# Load configuration
REGION=$(grep 'region:' config.yaml | awk '{print $2}')
STACK_NAME=$(grep 'stack_name:' config.yaml | awk '{print $2}')

SAM_TEMPLATE="template.yaml"
CF_TEMPLATE="cloudformation_template.yaml"

echo "Generating CloudFormation template from SAM template..."

sam build --template-file $SAM_TEMPLATE --region $REGION

if [ $? -eq 0 ]; then
    sam package \
        --template-file .aws-sam/build/template.yaml \
        --output-template-file $CF_TEMPLATE \
        --region $REGION

    if [ $? -eq 0 ]; then
        echo "CloudFormation template generated successfully: $CF_TEMPLATE"
        echo "You can now use this template to deploy directly from the AWS Console."
    else
        echo "Failed to package the CloudFormation template. Check the error message above."
        exit 1
    fi
else
    echo "Failed to build the SAM template. Check the error message above."
    exit 1
fi