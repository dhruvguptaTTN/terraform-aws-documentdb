module "document_db" {
  source = "git@github.com:narenderttn/terraform-aws-documentdb.git"  # Replace with the actual path to your module source

  app_name                       = "mongo-db"
  vpc_id                         = "vpc-0c7ca42512bbbb3df"
  security_group                 = ""
  project_name                   = "SWS"
  instance_class                 = "availability_zones"
  availability_zones             = ["us-east-1a","us-east-1b","us-east-1c"]
  parameter_group_family         = "docdb4.0"
  cluster_engine                 = "docdb"
  cluster_engine_version         = "4.0.0"
  mongo_master_db_username       = "admin"
  mongo_master_db_password       = "A9nPMZm9spwBFq68"
}
