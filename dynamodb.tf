resource "aws_dynamodb_table" "terraform_locks" {
  name         = local.tf_s3_bucket
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = local.tags
}
