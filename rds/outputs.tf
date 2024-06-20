output "rds_instance_sg_id" {
  value = aws_security_group.db_rds_instance.id
}

output "rds_instance_db_endpoint" {
  value = aws_db_instance.rds_instance.endpoint
}

output "rds_instance_db_dns" {
  value = aws_db_instance.rds_instance.address
}