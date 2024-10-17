# Observability Synthetic Canaries

This project uses AWS Serverless Application Model (SAM) to deploy CloudWatch Synthetic Canaries for monitoring S3 endpoints across multiple regions. It also sets up a CloudWatch Dashboard for visualizing the canary metrics.

## Project Overview

This project deploys the following AWS resources:

1. Two CloudWatch Synthetic Canaries:
   - A Heartbeat Canary that checks the availability of amazon.com
   - An API Canary that performs GET requests to multiple S3 endpoints
2. An S3 bucket to store canary artifacts
3. IAM roles and policies for the canaries
4. A CloudWatch Dashboard to visualize canary metrics

## Prerequisites

- AWS account with appropriate permissions
- AWS CLI
- AWS SAM CLI
- Node.js 12.x or later

## Setup and Deployment

### 1. Install AWS CLI

Follow the official AWS documentation for your operating system:
- For macOS: `brew install awscli`
- For Windows: https://awscli.amazonaws.com/AWSCLIV2.msi
- For Linux: https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2-linux.html

### 2. Create an IAM User

a. Go to AWS Console > IAM > Users > Add user
b. Set user name and enable \"Programmatic access\"
c. Attach policies: AWSCloudFormationFullAccess, IAMFullAccess, AmazonS3FullAccess, CloudWatchFullAccess
d. Complete user creation and save the Access Key ID and Secret Access Key

### 3. Configure AWS CLI

Run the following command and enter your Access Key ID, Secret Access Key, default region (e.g., us-east-1), and output format (json):

```
aws configure
```

### 4. Install AWS SAM CLI

Follow the official AWS documentation:
https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html

### 5. Clone the Repository

```
git clone https://github.com/snowtimber/observability-synthetic-canaries.git
cd observability-synthetic-canaries
```

### 6. Deploy the Stack

Run the deployment script:

```
chmod +x deploy.sh
./deploy.sh
```

This script will:
- Validate the CloudFormation template
- Deploy the stack using AWS CloudFormation
- Provide post-deployment instructions and useful links

## Resource Details

### Synthetic Canaries

#### Heartbeat Canary

- Checks the availability of https://amazon.com
- Takes a screenshot after successful load
- Reports on availability and latency

#### API Canary

- Performs GET requests to multiple S3 endpoints (configurable via environment variable)
- Validates successful responses
- Reports on availability and latency of each endpoint

### CloudWatch Dashboard

The dashboard provides visual metrics for both canaries, including:
- Heartbeat Latency
- Heartbeat Availability
- API Latency
- API Availability

## Customization

- Modify the `S3_ENDPOINTS` environment variable in the `template.yaml` file to monitor different S3 endpoints
- Adjust the canary scripts in the `template.yaml` file to change monitoring behavior
- Modify the CloudWatch Dashboard layout or metrics in the `template.yaml` file

## Post-Deployment Steps

1. Go to AWS CloudWatch console to view your Synthetic Canaries:
   https://[YOUR-REGION].console.aws.amazon.com/cloudwatch/home?region=[YOUR-REGION]#synthetics:canary/list

2. Check the CloudWatch Dashboard for canary metrics:
   https://[YOUR-REGION].console.aws.amazon.com/cloudwatch/home?region=[YOUR-REGION]#dashboards:

3. To make changes, edit the template.yaml file and re-run the deploy.sh script.

4. To delete the stack, run:
   ```
   aws cloudformation delete-stack --stack-name observability-synthetic-canaries --region [YOUR-REGION]
   ```

## Troubleshooting

If you encounter issues:
1. Check the CloudWatch Logs for each canary
2. Verify that the IAM roles have the correct permissions
3. Ensure that the S3 bucket names are globally unique
4. If deployment fails, check the CloudFormation events in the AWS Console for error messages

## Contributing

Contributions to improve this project are welcome. Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the LICENSE file for details.