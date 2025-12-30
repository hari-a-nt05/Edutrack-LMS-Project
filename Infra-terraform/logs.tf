resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/lms-frontend"
  retention_in_days = 7
}
