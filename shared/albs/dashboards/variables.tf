variable "prefix" {
  description = "Prefix for all the resources to be created"
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
  description = "Name of the application environment. e.g. development, production, staging"
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
}

variable "vpc_public_subnets_ids" {
  description = "Public subnet IDs"
}

variable "main_certificate_arn" {
  description = "ACM certificate Amazon Resource Name"
}

variable "main_route_53_zone_id" {
  description = "Main route53 Zone ID"
}

variable "dashboards_port" {
  description = "ALB routing port forthe service"
}

variable "domain" {
  description = "The domain name"
}
