terraform {
  backend "s3" {
    bucket         = "lms-hari-terraform-state-2415"
    key            = "lms/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock-hari"
    encrypt        = true
  }
}
 