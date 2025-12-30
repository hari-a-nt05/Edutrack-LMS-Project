resource "aws_ecs_task_definition" "frontend" {
  family                   = "lms-frontend-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "lms-frontend"
      image = "393078901209.dkr.ecr.us-east-1.amazonaws.com/lms-frontend:latest"
      portMappings = [
        {
          containerPort = 3000
          protocol      = "tcp"
        }
      ],
      logConfiguration = {
        logDriver = "awslogs",
        options = {
          awslogs-group         = "/ecs/lms-frontend",
          awslogs-region        = "us-east-1",
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}
