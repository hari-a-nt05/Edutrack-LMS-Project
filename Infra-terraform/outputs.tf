output "frontend_ecr_url" {
  value = aws_ecr_repository.frontend.repository_url
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.lms_cluster.name
}

output "vpc_id" {
  value = aws_vpc.lms_vpc.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id
  ]
}

output "frontend_url" {
  value = aws_lb.frontend_alb.dns_name
}


