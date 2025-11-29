terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.23.0"
    }
  }

  backend "s3" {

  bucket = "rk-state-managementmybucket"
  key = "terraform.tfstate"
  region = "us-west-2"
  dynamodb_table = "rk-state-management"
  profile = "terraform-personal"
  #use_lockfile = true
}
}

provider "aws" {
  region = "us-west-2"
  profile = "terraform-personal"
}

