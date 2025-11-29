resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "rk-state-management"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  
  tags = {
    Name        = "rk-state-management"
    Environment = "production"
  }
}