resource "aws_db_subnet_group" "lms_db_subnet_group" {
  name       = "lms-db-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "lms-db-subnet-group"
  }
}

resource "aws_db_instance" "lms_db" {
  identifier              = "lms-postgres-db"
  engine                  = "postgres"
  engine_version          = "15.4"
  instance_class          = "db.t3.micro"

  allocated_storage       = 20
  storage_type            = "gp2"

  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password

  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.lms_db_subnet_group.name

  publicly_accessible     = false
  skip_final_snapshot     = true
  deletion_protection     = false

  backup_retention_period = 7

  tags = {
    Name = "lms-postgres-db"
  }
}
