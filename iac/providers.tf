terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "devraghavm-terraform-medium-api-notification" // Here is your state bucket
    key    = "thumbnail-generator/state"
  }
}

// Region is set from AWS_REGION environment variable
provider "aws" {
}
