variable "app_name" {
	default = "mongo-db"
}

variable "project_name" {
	type = string
	default = "sws"
}

variable "env" {
    type = string
	default = ""
}

variable "vpc_id" {
    type = string
	default = ""
}

variable "instance_count" {
    type    = number
	description = "Number of DB instances to be created in the cluster"
	default = 2
}

variable "subnet_ids" {
	type = list(string)
	default = []
}

variable "cluster_type" {
	type = string
  	default = "instance_based_cluster"
}

variable "instance_class" {
	type    = string
	default = "db.r4.large"
}

variable "tags" {
    type = map(string)
	default = {}
}

variable "preferred_maintenance_window" {
	default = "Fri:09:00-Fri:09:30"
}

variable "availability_zones" {
	default = []
}

variable "preferred_backup_window" {
	default = "07:00-09:00"
}

variable "parameter_group_family" {
	default = "docdb5.0"
}

variable "cluster_engine" {
	default = "docdb"
}

variable "cluster_engine_version" {
	default = "5.0.0"
}

variable "mongo_master_db_username" {
	type    = string
	default = "admin"
}

variable "mongo_master_db_password" {
	type    = string
	default = "A9nPMZm9spwBFq68"
}