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

### 1. Install and Configure AWS CLI

If you haven't already installed the AWS CLI, follow these steps:

a. Install the AWS CLI by following the official AWS documentation for your operating system:
   https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html

b. Configure the AWS CLI with your credentials:
   ```
   aws configure
   ```
   You'll be prompted to enter your AWS Access Key ID, Secret Access Key, default region, and output format.

### 2. Install AWS SAM CLI

If you haven't installed the AWS SAM CLI, follow the official AWS documentation:
https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html

### 3. Clone the Repository

```
git clone https://github.com/snowtimber/observability-synthetic-canaries.git
cd observability-synthetic-canaries
```

### 4. Deploy the Stack

Run the deployment script:

```
chmod +x deploy.sh
./deploy.sh
```

This script will use the AWS SAM CLI to deploy the CloudFormation stack defined in `template.yaml`.

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