resource "aws_docdb_subnet_group" "subnet_group" {
  name        = "subnet-group-${var.app_name}"
  description = "Allowed subnets for DB cluster instances."
  subnet_ids  = var.subnet_ids
}

resource "aws_docdb_cluster_parameter_group" "cluster_parameter_group" {
  name        = "parameter-group-${var.app_name}"
  description = "DB cluster parameter group."
  family      = var.parameter_group_family
}

resource "aws_docdb_cluster" "cluster" {
	depends_on 						= [aws_docdb_subnet_group.subnet_group, aws_docdb_cluster_parameter_group.cluster_parameter_group]
	cluster_identifier              = "${var.project_name}-${var.app_name}"
	engine                          = var.cluster_engine
	engine_version                  = var.cluster_engine_version
	master_username                 = var.mongo_master_db_username
	master_password                 = var.mongo_master_db_password
	backup_retention_period         = 7
	preferred_backup_window         = var.preferred_backup_window
	preferred_maintenance_window    = var.preferred_maintenance_window
	skip_final_snapshot             = true
	apply_immediately               = true
	availability_zones              = var.availability_zones
	db_subnet_group_name            = aws_docdb_subnet_group.subnet_group.id
	db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.cluster_parameter_group.id
	deletion_protection             = true
	storage_encrypted               = true
	port                            = "27017"
	vpc_security_group_ids          = var.security_group
	# tags        = merge(local.common_tags, tomap({"Name":"${local.service_name_prefix}-${var.app_name}"}))
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
	depends_on 					 = [aws_docdb_cluster.cluster]
	count                        = var.instance_count
	identifier                   = "${var.project_name}-${var.app_name}-${instance_count.index}"
	cluster_identifier           = aws_docdb_cluster.cluster.id
	instance_class               = lookup(var.instance_class, terraform.workspace, "undefined")
	apply_immediately            = true
	auto_minor_version_upgrade   = true
	engine                       = aws_docdb_cluster.cluster.engine
	preferred_maintenance_window = var.preferred_maintenance_window
	# tags        = merge(local.common_tags, tomap({"Name":"${local.service_name_prefix}-${var.app_name}"}))
}