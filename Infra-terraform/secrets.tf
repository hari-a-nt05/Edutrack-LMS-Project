resource "aws_secretsmanager_secret" "db_secret" {
  name = "${var.project_name}/db/postgres-v3"
}
