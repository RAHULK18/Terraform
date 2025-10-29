terraform {
  backend "s3" {
    bucket = "state-demo-rk"
    region = "us-west-2"
    key = "rahul/terraform.tfstate"
    profile = "terraform-personal"
    dynamodb_endpoint = "terraform-lock"
  }
}