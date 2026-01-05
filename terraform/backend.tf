terraform {
  backend "s3" {
    bucket         = "hari-terraform-state-edutrack"
    key            = "lms/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "hari-terraform-lock"
    encrypt        = true
  }
}
