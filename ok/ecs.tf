
# ECS Cluster (Frontend Only)
resource "aws_ecs_cluster" "lms_cluster" {
  name = "lms-frontend-cluster"

  tags = {
    Name = "lms-frontend-cluster"
  }
}


# IAM Role for ECS Task Execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "lms-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "lms-ecs-task-execution-role"
  }
}

# Attach Amazon ECS Task Execution Policy
resource "aws_iam_role_policy_attachment" "ecs_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
