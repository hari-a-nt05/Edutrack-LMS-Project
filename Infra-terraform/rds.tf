resource "aws_db_subnet_group" "db_subnets" {
  name = "${lower(var.project_name)}-db-subnets"

  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "${lower(var.project_name)}-db-subnets"
  }
}

resource "aws_db_instance" "postgres" {
  identifier = "${lower(var.project_name)}-db"

  engine         = "postgres"
  engine_version = "15"
  instance_class = "db.t4g.micro"

  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_user
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  publicly_accessible = false

  backup_retention_period = 0
  skip_final_snapshot     = true
  deletion_protection     = false

  tags = {
    Name        = "${lower(var.project_name)}-postgres"
    Environment = "production"
  }
}
