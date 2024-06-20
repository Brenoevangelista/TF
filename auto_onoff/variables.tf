
variable "tags" {
  description = "AWS Tags to add to all resources created (where possible); see https://aws.amazon.com/answers/account-management/aws-tagging-strategies/"
  type        = map(any)
  default     = {}
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

variable "environment" {
  description = "Name of the application environment. e.g. dev, prod, test, staging"
}