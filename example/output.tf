output "db_password"{
    value = module.document_db.random_password.db_password.result
    sensitive = false
}