terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "3.38"
    }
  }
  required_version = ">=0.15.3"
}


provider "aws" {
  region = "us-east-2"
}


module "backend-config" {
   source = "../../../modules/backends/s3"
   bucket_name = "courage-prod-bucket-name"
   dynamodb_name = "courage-prod-table-locks"
}