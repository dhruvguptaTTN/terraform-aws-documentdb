variable "app_name" {
	default = "mongo-db"
}

variable "project_name" {
	type = string
}

variable "security_group" {
	type    = map(list(string))
	default = {
		non-prod = ["sg-0887b64489117141d"]
		prod     = ["sg-04961807801382c11"]
		beta     = ["sg-04961807801382c11"]
	}
}

variable "instance_class" {
	type    = map(string)
	default = {
		non-prod = "db.t3.medium"
		prod     = "db.r5.large"
		beta     = "db.t3.medium"
	}
}

variable "preferred_maintenance_window" {
	default = "Fri:09:00-Fri:09:30"
}

variable "availability_zones" {
	default = [
		"ap-south-1a",
		"ap-south-1b",
        "ap-south-1c"]
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