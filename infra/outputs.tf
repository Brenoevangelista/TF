# outputs.tf

output "alb_hostname" {
  value = aws_alb.lead-score-api.dns_name
}

output "redis_endpoint" {
  value = aws_elasticache_cluster.redis.primary_endpoint_address
}

output "redis_port" {
  value = aws_elasticache_cluster.redis.port
}
