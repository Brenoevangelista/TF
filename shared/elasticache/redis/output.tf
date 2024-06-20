output "shared_elasticache_redis_sg_id" {
  value = aws_security_group.shared_redis_cache.id
}