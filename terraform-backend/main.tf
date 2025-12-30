resource "aws_s3_bucket" "tf_state" {
  bucket = "lms-vicky-terraform-state-492000"

  versioning {
    enabled = true
  }
}


resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}


