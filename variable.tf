variable "app_name" {
	default = "mongo-db"
}

variable "project_name" {
	type = string
	default = "SWS"
}

variable "security_group" {
	type    = list(string)
	default = []
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

variable "preferred_maintenance_window" {
	default = "Fri:09:00-Fri:09:30"
}

variable "availability_zones" {
	default = [
		"us-east-1a",
		"us-east-1b",
        "us-east-1c"]
}

variable "preferred_backup_window" {
	default = "07:00-09:00"
}

variable "parameter_group_family" {
	default = "docdb4.0"
}

variable "cluster_engine" {
	default = "docdb"
}

variable "cluster_engine_version" {
	default = "4.0.0"
}

variable "mongo_master_db_username" {
	type    = string
	default = "admin"
}

variable "mongo_master_db_password" {
	type    = string
	default = "A9nPMZm9spwBFq68"
}