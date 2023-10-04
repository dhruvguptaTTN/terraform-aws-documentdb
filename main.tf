resource "aws_docdb_subnet_group" "subnet_group" {
	name       = "docdb-subnet-group"
	subnet_ids = ["subnet-043d59b3957d49e1d","subnet-093641ce3f549831e"]
	description = "SWS Subnet Group"
}

resource "aws_docdb_cluster_parameter_group" "cluster_parameter_group" {
	name        = "${var.project_name}-parameter-group"
	family      = var.parameter_group_family
	description = "${var.project_name} - Parameter Group"
}

resource "aws_docdb_cluster" "cluster" {
	count 							= var.cluster_type=="elastic_cluster" ? 1 : 0
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
	vpc_security_group_ids          = lookup(var.security_group, terraform.workspace, ["undefined"])
	# tags        = merge(local.common_tags, tomap({"Name":"${local.service_name_prefix}-${var.app_name}"}))
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
	depends_on 					 = [aws_docdb_cluster.cluster]
	count 						 = var.cluster_type=="instance_based_based" ? 1 : 0
	identifier                   = "${local.service_name_prefix}-${var.app_name}-${count.index}"
	cluster_identifier           = aws_docdb_cluster.cluster.id
	instance_class               = lookup(var.instance_class, terraform.workspace, "undefined")
	apply_immediately            = true
	auto_minor_version_upgrade   = true
	engine                       = aws_docdb_cluster.cluster.engine
	preferred_maintenance_window = var.preferred_maintenance_window
	# tags        = merge(local.common_tags, tomap({"Name":"${local.service_name_prefix}-${var.app_name}"}))
}