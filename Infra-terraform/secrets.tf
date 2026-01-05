resource "aws_secretsmanager_secret" "db_secret" {
  name = "hari/db/postgres"
}
