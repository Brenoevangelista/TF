locals {
  subnet_ids = { for k, v in aws_subnet.this : v.tags.Name => v.id }

  common_tags = {
    Project   = "VPC DADOS"
    CreatedAt = "2024-05-07"
    ManagedBy = "Terraform"
    Owner     = "Wesley Leite"
    Service   = "Network"
  }
}
