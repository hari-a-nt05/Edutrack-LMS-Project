resource "aws_ecs_service" "frontend_service" {
  name            = "lms-frontend-service"
  cluster         = aws_ecs_cluster.lms_cluster.id
  task_definition = aws_ecs_task_definition.frontend.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets = [
      aws_subnet.public_subnet_1.id,
      aws_subnet.public_subnet_2.id
    ]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.frontend_tg.arn
    container_name   = "lms-frontend"
    container_port   = 3000
  }

  depends_on = [
    aws_lb_listener.frontend_listener
  ]
}
