variable "prefix" {
  description = "Prefix for all the resources to be created. Please note thst 2 allows only lowercase alphanumeric characters and hyphen"
}

variable "aws_region" {
  description = "Region AWS"
}

variable "tags" {
  description = "AWS Tags to add to all resources created (where possible); see https://aws.amazon.com/answers/account-management/aws-tagging-strategies/"
  type        = map(any)
  default     = {}
}

variable "environment" {
  description = "Name of the application environment. e.g. dev, prod, test, staging"
}

variable "owner" {
  description = "Application Owner email address"
}

variable "main_certificate_arn" {
  description = "ACM certificate Amazon Resource Name"
}

variable "main_route_53_zone_id" {
  description = "Route 53 Hosted Zone ID "
}

variable "domain" {
  description = "Domain Name"
}

variable "resources_list" {
  default = ["api", "v1"]
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "vpc_private_subnets_ids" {
  description = "Private subnet IDs"
}