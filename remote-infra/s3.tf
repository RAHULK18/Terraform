resource "aws_s3_bucket" "state-lock" {
  bucket = "rk-state-managementmybucket"

  tags = {
    Name        = "rk-state-managementmybucket"
    Environment = "prod"
  }
}