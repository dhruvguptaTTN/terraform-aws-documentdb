output db_passsword {
  value     = random_password.db_password.result
  sensitive = false
}