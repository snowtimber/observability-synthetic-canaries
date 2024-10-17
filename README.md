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

- AWS CLI installed and configured
- AWS SAM CLI installed
- GitHub CLI (gh) installed and authenticated (for initial setup)
- Node.js 12.x or later

## Project Structure

- `template.yaml`: SAM template defining AWS resources
- `deploy.sh`: Script to deploy the CloudFormation stack
- `github_push_initial.sh`: Script for initial GitHub repository setup
- `github_push_reoccuring.sh`: Script for subsequent GitHub pushes
- `README.md`: This file, containing project documentation

## Setup and Deployment

1. Clone this repository:
   ```
   git clone https://github.com/snowtimber/observability-synthetic-canaries.git
   cd observability-synthetic-canaries
   ```

2. (Optional) If this is a new project, run the initial GitHub push script:
   ```
   chmod +x github_push_initial.sh
   ./github_push_initial.sh
   ```

3. Deploy the CloudFormation stack:
   ```
   chmod +x deploy.sh
   ./deploy.sh
   ```

4. For subsequent updates, use the recurring GitHub push script:
   ```
   chmod +x github_push_reoccuring.sh
   ./github_push_reoccuring.sh \"Your commit message\"
   ```

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

### IAM Roles and Policies

The template creates an IAM role with permissions for the canaries to:
- Write artifacts to the S3 bucket
- Perform API calls to S3 endpoints
- Write logs and metrics to CloudWatch

## Customization

- Modify the `S3_ENDPOINTS` environment variable in the `template.yaml` file to monitor different S3 endpoints
- Adjust the canary scripts in the `template.yaml` file to change monitoring behavior
- Modify the CloudWatch Dashboard layout or metrics in the `template.yaml` file

## Troubleshooting

If you encounter issues:
1. Check the CloudWatch Logs for each canary
2. Verify that the IAM roles have the correct permissions
3. Ensure that the S3 bucket names are globally unique

## Contributing

Contributions to improve this project are welcome. Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the LICENSE file for details.