module "document_db" {
  source = "git@github.com:tothenew/terraform-aws-documentdb.git"  # Replace with the actual path to your module source

  app_name                       = "mongo-db"
  env                            = "dev"
  vpc_id                         = "vpc-0c7ca42512bbbb"
  subnet_ids                     = ["subnet-043d59b3957d49","subnet-093641ce3f5498","subnet-0d911d25c86c0a"]
  project_name                   = "sws"
  instance_class                 = "db.r6g.large"
  availability_zones             = ["us-east-1a","us-east-1b","us-east-1c"]
  parameter_group_family         = "docdb5.0"
  cluster_engine                 = "docdb"
  cluster_engine_version         = "5.0.0"
  mongo_master_db_username       = "admin1"
}
