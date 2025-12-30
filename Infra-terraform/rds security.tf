resource "aws_security_group" "rds_sg" {
  name        = "lms-rds-sg"
  description = "Allow DB access from ECS only"
  vpc_id      = aws_vpc.lms_vpc.id   # reuse existing VPC

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.ecs_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "lms-rds-sg"
  }
}
