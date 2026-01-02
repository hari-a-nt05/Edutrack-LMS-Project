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
  description = "ECS task definition ARN"
  value       = aws_ecs_task_definition.task.arn
}

########################################
# Networking outputs
########################################

output "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  value       = aws_subnet.private[*].id
}

output "ecs_security_group_id" {
  description = "ECS security group ID"
  value       = aws_security_group.ecs_sg.id
}

########################################
# Optional / debugging
########################################

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main.id
}

output "alb_security_group_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb_sg.id
}
