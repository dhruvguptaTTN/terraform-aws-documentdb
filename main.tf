resource "aws_docdb_subnet_group" "subnet_group" {
	name       = "${local.service_name_prefix}-subnet-group"
	subnet_ids = [
		data.terraform_remote_state.vpc_static.outputs.private_subnet_3,
		data.terraform_remote_state.vpc_static.outputs.private_subnet_4
	]
	description = "${var.project_name} - Subnet Group"
	tags       = merge(local.common_tags, tomap({"Name":"${local.service_name_prefix}-subnet-group"}))
}

resource "aws_docdb_cluster_parameter_group" "cluster_parameter_group" {
	name        = "${local.service_name_prefix}-parameter-group"
	family      = var.parameter_group_family
	description = "${var.project_name} - Parameter Group"
	tags        = merge(local.common_tags, tomap({"Name":"${local.service_name_prefix}-parameter-group"}))
}

resource "aws_docdb_cluster" "cluster" {
	count 							= var.cluster_type=="instance_based_based" 
	depends_on 						= [aws_docdb_subnet_group.subnet_group, aws_docdb_cluster_parameter_group.cluster_parameter_group]
	cluster_identifier              = "${local.service_name_prefix}-${var.app_name}"
	engine                          = var.cluster_engine
	engine_version                  = var.cluster_engine_version
	master_username                 = lookup(var.mongo_master_db_username, terraform.workspace,"undefined")
	master_password                 = lookup(var.mongo_master_db_password, terraform.workspace,"undefined")
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
	tags        = merge(local.common_tags, tomap({"Name":"${local.service_name_prefix}-${var.app_name}"}))
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
	depends_on = [aws_docdb_cluster.cluster]
	count                        = 1
	identifier                   = "${local.service_name_prefix}-${var.app_name}-${count.index}"
	cluster_identifier           = aws_docdb_cluster.cluster.id
	instance_class               = lookup(var.instance_class, terraform.workspace, "undefined")
	apply_immediately            = true
	auto_minor_version_upgrade   = true
	engine                       = aws_docdb_cluster.cluster.engine
	preferred_maintenance_window = var.preferred_maintenance_window
	tags        = merge(local.common_tags, tomap({"Name":"${local.service_name_prefix}-${var.app_name}"}))
}