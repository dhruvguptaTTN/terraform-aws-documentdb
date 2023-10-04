module "document_db" {
  source = "git@github.com:narenderttn/terraform-aws-documentdb.git"  # Replace with the actual path to your module source

  app_name                       = var.app_name
  project_name                   = var.project_name
  security_group                 = var.security_group
  instance_class                 = var.instance_class
  preferred_maintenance_window   = var.preferred_maintenance_window
  availability_zones             = var.availability_zones
  preferred_backup_window        = var.preferred_backup_window
  parameter_group_family         = var.parameter_group_family
  cluster_engine                 = var.cluster_engine
  cluster_engine_version         = var.cluster_engine_version
  mongo_master_db_username       = var.mongo_master_db_username
  mongo_master_db_password       = var.mongo_master_db_password
}
