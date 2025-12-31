########################################
# Application-facing outputs
########################################

output "alb_dns" {
  description = "Public DNS of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "ecr_repo_url" {
  description = "ECR repository URL for the application image"
  value       = aws_ecr_repository.repo.repository_url
}

output "rds_endpoint" {
  description = "RDS PostgreSQL endpoint (hostname only)"
  value       = aws_db_instance.postgres.address
}

########################################
# ECS / CI-CD critical outputs
########################################

output "ecs_cluster_name" {
  description = "ECS cluster name"
  value       = aws_ecs_cluster.cluster.name
}

output "ecs_service_name" {
  description = "ECS service name"
  value       = aws_ecs_service.service.name
}

output "ecs_task_definition_arn" {
  description = "ECS task definition ARN (used for run-task migrations)"
  value       = aws_ecs_task_definition.app.arn
}

########################################
# Networking outputs (Fargate runtime)
########################################

output "private_subnet_ids" {
  description = "Private subnet IDs for ECS Fargate tasks"
  value = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]
}

output "ecs_security_group_id" {
  description = "Security group ID attached to ECS tasks"
  value       = aws_security_group.ecs.id
}

########################################
# Optional / debugging helpers
########################################

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "alb_security_group_id" {
  description = "Security group ID of the ALB"
  value       = aws_security_group.alb.id
}
