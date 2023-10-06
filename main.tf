resource "aws_docdb_subnet_group" "subnet_group" {
  name        = "${var.app_name}-subnet-group"
  description = "Allowed subnets for DB cluster instances."
  subnet_ids  = var.subnet_ids
}

resource "aws_docdb_cluster_parameter_group" "cluster_parameter_group" {
  name        = "${var.app_name}-parameter-group"
  description = "DB cluster parameter group."
  family      = var.parameter_group_family
}

resource "aws_security_group" "docdb_sg" {
  name        = "Security Group-${var.app_name}"
  description = "Allow inbound traffic"

  vpc_id = var.vpc_id

  ingress {
    from_port   = "27017"
    to_port     = "27017"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "random_password" "db_password" {
  length           = 16
  special          = true
}

resource "aws_docdb_cluster" "cluster" {
	depends_on 						= [aws_docdb_subnet_group.subnet_group, aws_docdb_cluster_parameter_group.cluster_parameter_group]
	cluster_identifier              = "${var.project_name}-${var.app_name}"
	engine                          = var.cluster_engine
	engine_version                  = var.cluster_engine_version
	master_username                 = var.mongo_master_db_username
	master_password                 = random_password.db_password.result
	backup_retention_period         = 7
	preferred_backup_window         = var.preferred_backup_window
	preferred_maintenance_window    = var.preferred_maintenance_window
	skip_final_snapshot             = true
	apply_immediately               = true
	availability_zones              = var.availability_zones
	db_subnet_group_name            = aws_docdb_subnet_group.subnet_group.id
	db_cluster_parameter_group_name = aws_docdb_cluster_parameter_group.cluster_parameter_group.id
	deletion_protection             = false
	storage_encrypted               = true
	port                            = "27017"
	vpc_security_group_ids          = [aws_security_group.docdb_sg.id]
	tags = merge(
    var.tags,
    {
      "Engine" = var.cluster_engine
	  "Environment" = var.env
	  "Project" = var.project_name
	}
  )
}

resource "aws_docdb_cluster_instance" "cluster_instances" {
	depends_on 					 = [aws_docdb_cluster.cluster]
	count                        = var.instance_count
	identifier                   = "${var.project_name}-${var.app_name}-${count.index}"
	cluster_identifier           = aws_docdb_cluster.cluster.id
	instance_class               = var.instance_class
	apply_immediately            = true
	auto_minor_version_upgrade   = true
	engine                       = aws_docdb_cluster.cluster.engine
	preferred_maintenance_window = var.preferred_maintenance_window
	tags = merge(
    var.tags,
    {
      "Engine" = var.cluster_engine
	  "Environment" = var.env
	  "Project" = var.project_name
	}
  )
}