variable "db_name" {
  default = "lmsdb"
}

variable "db_username" {
  default = "lms_admin"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "private_subnet_ids" {
  type = list(string)
}
