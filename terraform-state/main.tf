provider "aws" {
      region = "us-west-2"
      profile = "terraform-personal"
}

resource "aws_instance" "terraform-ec2" {
      ami ="ami-0e1d35993cb249cee"
      instance_type = "t2.micro"
}
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "state-demo-rk"
}

resource "aws_dynamodb_table" "terraform-lock" {
  name = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}
