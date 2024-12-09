terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
    backend "s3" {
        bucket = "vpc-dev"
        key    = "vpc-dev-key"
        region = "us-east-1"
        dynamodb_table = "vpc-dev-locking"
  }
  
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}