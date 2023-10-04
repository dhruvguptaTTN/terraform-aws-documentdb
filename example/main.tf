module "document_db" {
  source = "git@github.com:narenderttn/terraform-aws-documentdb.git"  # Replace with the actual path to your module source

  app_name                       = "mongo-db"
  security_group                 = ["sg-0f84c3eb782be6630"]
  subnet_ids                     = ["subnet-043d59b3957d49e1d","subnet-093641ce3f549831e","subnet-0d911d25c86c0a429"]
  project_name                   = "sws"
  instance_class                 = "db.r4.large"
  availability_zones             = ["us-east-1a","us-east-1b","us-east-1c"]
  parameter_group_family         = "docdb4.0"
  cluster_engine                 = "docdb"
  cluster_engine_version         = "4.0.0"
  mongo_master_db_username       = "admin"
  mongo_master_db_password       = "A9nPMZm9spwBFq68"
}
