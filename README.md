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

### 6. Configure the Project

Edit the `config.yaml` file to set your desired AWS region and stack name:

```yaml
region: us-east-1
stack_name: observability-synthetic-canaries
```

## Deployment Options

### Option 1: Deploy using AWS SAM CLI

1. Run the deployment script:

   ```
   chmod +x deploy.sh
   ./deploy.sh
   ```

   This script will:
   - Validate the SAM template
   - Deploy the stack using AWS SAM CLI with the necessary IAM capabilities
   - Provide post-deployment instructions and useful links

2. If you prefer to run the SAM deploy command manually, use:

   ```
   sam deploy \\
       --template-file template.yaml \\
       --stack-name observability-synthetic-canaries \\
       --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \\
       --region <your-region> \\
       --guided
   ```

   Replace `<your-region>` with your desired AWS region.

### Option 2: Deploy using AWS Console

If you prefer to deploy the stack directly through the AWS Console, follow these steps:

1. Generate the CloudFormation template:

   ```
   chmod +x generate_cloudformation_template.sh
   ./generate_cloudformation_template.sh
   ```

   This will create a file named `cloudformation_template.yaml` in your current directory.

2. Log in to the AWS Management Console and navigate to the CloudFormation service.

3. Click \"Create stack\" and choose \"With new resources (standard)\".

4. In the \"Specify template\" section, choose \"Upload a template file\".

5. Click \"Choose file\" and select the `cloudformation_template.yaml` file you generated.

6. Click \"Next\" and follow the prompts to create the stack:
   - Enter the stack name from your `config.yaml` file
   - Review the parameters (if any)
   - Configure stack options as needed
   - On the \"Review\" page, make sure to check the box that says \"I acknowledge that AWS CloudFormation might create IAM resources.\"
   - Review and create the stack

7. Wait for the stack creation to complete. You can monitor the progress in the CloudFormation console.

## Resource Details

### Synthetic Canaries

#### Heartbeat Canary

- Checks the availability of https://amazon.com
- Takes a screenshot after successful load
- Reports on availability and latency

#### API Canary

- Performs HEAD requests to the following open data S3 endpoints:
  - `https://sentinel-s2-l1c.s3.eu-central-1.amazonaws.com`
  - `https://sentinel-inventory.s3.eu-central-1.amazonaws.com/sentinel-s2-l1c`
- Validates successful responses (status code between 200-299)
- Reports on availability and latency of each endpoint

The API Canary checks the availability of an open data set hosted on S3 buckets in the `eu-central-1` region. The data set contains Level 1C scenes and metadata for the Sentinel-2 satellite mission.

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

3. To make changes, edit the template.yaml file and re-run the deployment process.

4. To delete the stack, run:
   ```
   aws cloudformation delete-stack --stack-name [YOUR-STACK-NAME] --region [YOUR-REGION]
   ```
   Replace [YOUR-STACK-NAME] and [YOUR-REGION] with the values from your `config.yaml` file.

## Troubleshooting

1. Check the CloudWatch Logs for each canary
2. Verify that the IAM roles have the correct permissions
3. Ensure that the S3 bucket names are globally unique
4. If deployment fails, check the CloudFormation events in the AWS Console for error messages
5. If you encounter a \"permission denied\" error when running the scripts, ensure you've set the execute permissions using `chmod +x script_name.sh`
6. If the generated CloudFormation template is empty or incomplete, make sure your SAM template (`template.yaml`) is valid and contains all necessary resources
7. If you encounter an error about missing IAM capabilities (e.g., \"Requires capabilities : [CAPABILITY_IAM]\"), make sure you're using the updated `deploy.sh` script or including the `--capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM` flags in your SAM deploy command

## Contributing

Contributions to improve this project are welcome. Please fork the repository and submit a pull request with your changes.

## License

This project is licensed under the MIT License - see the LICENSE file for details.