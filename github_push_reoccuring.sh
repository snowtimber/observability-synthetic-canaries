#!/bin/bash
# usage: 
# chmod +x github_push_reoccuring.sh
# ./github_push_reoccuring.sh "Your commit message"

# GitHub repository details
GITHUB_USERNAME="snowtimber"
REPO_NAME="observability-synthetic-canaries"

# Check if a commit message was provided
if [ $# -eq 0 ]; then
    echo "Error: No commit message provided."
    echo "Usage: ./github_push_reoccuring.sh \"Your commit message\""
    exit 1
fi

# Commit message
COMMIT_MESSAGE="$1"

# Update .gitignore file if needed
echo "Checking .gitignore file..."
if [ ! -f .gitignore ]; then
    echo "Creating .gitignore file..."
    cat << EOF > .gitignore
*.log
.env
node_modules/
EOF
fi

# Update README.md file if needed
echo "Checking README.md file..."
if [ ! -f README.md ]; then
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
fi

# Add all files to Git
echo "Adding files to Git..."
git add .

# Commit changes
echo "Committing changes..."
git commit -m "$COMMIT_MESSAGE"

# Push to GitHub
echo "Pushing to GitHub..."
git push origin main

echo "Changes successfully pushed to GitHub!"
echo "Repository URL: https://github.com/$GITHUB_USERNAME/$REPO_NAME"