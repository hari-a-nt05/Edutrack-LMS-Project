resource "aws_ecr_repository" "frontend" {
  name         = "lms-frontend"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = {
    Name = "lms-frontend-ecr"
  }
}
