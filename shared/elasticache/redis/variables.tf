variable "prefix" {
  description = "Prefix for all the resources to be created. Please note thst 2 allows only lowercase alphanumeric characters and hyphen"
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

variable "environment" {
  description = "Name of the application environment. e.g. dev, prod, test, staging"
}

variable "tags" {
  description = "AWS Tags to add to all resources created (where possible); see https://aws.amazon.com/answers/account-management/aws-tagging-strategies/"
  type        = map(any)
  default     = {}
}

variable "shared_elasticache_private_subnets" {
  description = "Elasticache Shared private subnets IDs"
}

variable "allowed_security_groups" {
  description = "Elasticache allowed security groups"
}
