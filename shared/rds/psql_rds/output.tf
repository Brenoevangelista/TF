output "shared_psql_rds_sg_id" {
  value = aws_security_group.shared_psql_rds_instance.id
}

output "shared_psql_rds_hostname" {
  value = aws_db_instance.shared_psql_rds_instance.endpoint
}

output "shared_psql_rds_endpoint" {
  value = aws_db_instance.shared_psql_rds_instance.address
}