terraform {
  backend "s3" {
    bucket         = "lms-vicky-terraform-state-492000"
    key            = "lms/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
