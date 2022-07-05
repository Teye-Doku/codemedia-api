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

module "prod-backend" {
  source          = "../../../modules/services/webserver-cluster"
  server_port     =  8000
  region          = "us-east-2"
  instance_type   = "t2.micro"
}

terraform {
   backend "s3" {
     bucket = "courage-prod-bucket-name"
     key = "prod/services/webserver-cluster/terraform.tfstate"
     region = "us-east-2"
     dynamodb_table = "courage-prod-table-locks"
     encrypt = true
   }
}