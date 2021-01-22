terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.24"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region                  = "us-west-2"
  shared_credentials_file = "/home/uchinda/.aws/credentials"
  profile                 = "personal"
}

# Configure AWS credentails via the AWS_SHARED_CREDENTIALS_FILE and AWS_PROFILE environment variables