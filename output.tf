output "subnet_group_id" {
	value = aws_docdb_subnet_group.subnet_group.id
}

output "subnet_group_arn" {
	value = aws_docdb_subnet_group.subnet_group.arn
}

output "cluster_parameter_group_id" {
	value = aws_docdb_cluster_parameter_group.cluster_parameter_group.id
}

output "cluster_parameter_group_arn" {
	value = aws_docdb_cluster_parameter_group.cluster_parameter_group.arn
}

output "cluster_arn" {
	value = aws_docdb_cluster.cluster.arn
}

output "cluster_id" {
	value = aws_docdb_cluster.cluster.id
}

output "cluster_endpoint" {
	value = aws_docdb_cluster.cluster.endpoint
}

output "cluster_reader_endpoint" {
	value = aws_docdb_cluster.cluster.reader_endpoint
}
