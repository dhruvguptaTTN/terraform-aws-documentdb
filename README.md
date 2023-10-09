# terraform-aws-documentdb

[![Lint Status](https://github.com/tothenew/terraform-aws-template/workflows/Lint/badge.svg)](https://github.com/tothenew/terraform-aws-template/actions)
[![LICENSE](https://img.shields.io/github/license/tothenew/terraform-aws-template)](https://github.com/tothenew/terraform-aws-template/blob/master/LICENSE)

This is the RDS module which will create the DocumentDB Instance base Cluster.
The following resources will be created:
- DocumentDB Cluster and Instances
- Subnet Group
- Cluster Parameter Group
- Security Group

## Usages
```
module "document_db" {
  source = "git@github.com:tothenew/terraform-aws-documentdb.git"  

  app_name                       = "mongo-db"
  env                            = "dev"
  vpc_id                         = "vpc-0c7ca42512bbbb"
  subnet_ids                     = ["subnet-043d59b3957d49","subnet-093641ce3f5498","subnet-0d911d25c86c0a"]
  project_name                   = "your_project_name"
  instance_class                 = "db.r6g.large"
  availability_zones             = ["us-east-1a","us-east-1b","us-east-1c"]
  parameter_group_family         = "docdb5.0"
  cluster_engine                 = "docdb"
  cluster_engine_version         = "5.0.0"
  mongo_master_db_username       = "admin1"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Authors

Module managed by [TO THE NEW Pvt. Ltd.](https://github.com/tothenew)

## License

Apache 2 Licensed. See [LICENSE](https://github.com/tothenew/terraform-aws-template/blob/main/LICENSE) for full details.