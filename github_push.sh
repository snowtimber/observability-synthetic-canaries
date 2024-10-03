#!/bin/bash
# usage: 
# chmod +x github_push.sh
# ./github_push.sh

# GitHub repository details
GITHUB_USERNAME="snowtimber"
REPO_NAME="observability-synthetic-canaries"

# Create .gitignore file
echo "Creating .gitignore file..."
cat << EOF > .gitignore
*.log
.env
node_modules/
EOF

# Create README.md file
echo "Creating README.md file..."
cat << EOF > README.md
# Observability Synthetic Canaries

This project uses AWS SAM to deploy CloudWatch Synthetic Canaries for monitoring S3 endpoints across multiple regions.

## Setup and Deployment

1. Ensure you have AWS CLI and SAM CLI installed and configured.
2. Update the \`S3_BUCKET_NAME\` in the deploy.sh script.
3. Run \`./deploy.sh\` to deploy the stack.

## Resources Created

- IAM Role for Synthetic Canary
- CloudWatch Synthetic Canary
- CloudWatch Dashboard

For more details, please refer to the \`template.yaml\` file.
EOF

# Initialize Git repository
echo "Initializing Git repository..."
git init

# Add all files to Git
echo "Adding files to Git..."
git add .

# Commit changes
echo "Committing changes..."
git commit -m "Initial commit: Add SAM template for S3 endpoint monitoring canaries"

# Create GitHub repository using GitHub CLI
# Note: This requires GitHub CLI (gh) to be installed and authenticated
echo "Creating GitHub repository..."
gh repo create $REPO_NAME --public --description "AWS SAM project for CloudWatch Synthetic Canaries monitoring S3 endpoints" --remote origin

# Push to GitHub
echo "Pushing to GitHub..."
git push -u origin main

echo "Project successfully pushed to GitHub!"
echo "Repository URL: https://github.com/$GITHUB_USERNAME/$REPO_NAME"