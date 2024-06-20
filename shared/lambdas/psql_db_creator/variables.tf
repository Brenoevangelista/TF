
variable "tags" {
  description = "AWS Tags to add to all resources created (where possible); see https://aws.amazon.com/answers/account-management/aws-tagging-strategies/"
  type        = map(any)
  default     = {}
}

variable "aws_account_id" {
  description = "AWS Account ID"
}

variable "prefix" {
  description = "Prefix for all the resources to be created. Please note thst 2 allows only lowercase alphanumeric characters and hyphen"
}

variable "aws_region" {
  description = "Region AWS"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "vpc_id" {
  description = "The ID for the VPC"
}

variable "vpc_private_subnets_ids" {
  description = "Private subnets IDs"
}

variable "environment" {
  description = "Name of the application environment. e.g. dev, prod, test, staging"
}

variable "shared_psql_db_instance_endpoint" {
  description = "Shared RDS PostgreSQL database endpoint url"
}


      