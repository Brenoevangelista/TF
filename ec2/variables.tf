##GLOBAL_VARIABLES
variable "prefix" {
  description = "Prefix for all the resources to be created. Please note thst 2 allows only lowercase alphanumeric characters and hyphen"
}

variable "aws_region" {
  description = "Region AWS"
}

variable "state_backend" {
  description = "Remote Terraform state backend"
}

variable "app_name" {
  description = "Application Name"
}

variable "environment" {
  description = "Name of the application environment. e.g. dev, prod, test, staging"
}

variable "tf_environment" {
  description = "Terraform workspace environment"
}

variable "owner" {
  description = "Application Owner email address"
}

variable "team" {
  description = "Team responsible for the resource"
}

variable "auto_onoff" {
  description = "Boolean to auto start and stop a resource"
}

variable "s3_tf_app_state" {
  description = "Terraform state bucket name"
}

variable "vpc_id" {
  description = "AWS VPC ID"
}

#EC2 VARIABLES
variable "ami" {
  description = "EC2 Amazon Machine Image ID"
}

variable "instance_type" {
  description = "EC2 instance type and size, ex; t4g.micro"
}

variable "keypair" {
  description = "EC2 instance key pair name"
}

variable "target_subnet_id" {
  description = "Desired subnet to place a resource"
}

variable "public_ip" {
  description = "EC2 instance key pair name"
}

variable "root_ebs_encrypted" {
  description = "Root volume Boolean to enable encryption"
}

variable "root_ebs_size" {
  description = "Root volume size in GiBs"
}

variable "root_ebs_type" {
  description = "Root volume type"
}

variable "aws_production_cidr" {
  description = "AWS Solides Production account VPC CIDR bloc"
}

variable "solides_vpn" {
  description = "AWS Solides Production account VPC CIDR bloc"
}

variable "solides_onpremise" {
  description = "AWS Solides Production account VPC CIDR bloc"
}


#CLOUDFRONT VARIABLES

variable "application_domain_name" {
  description = "Application's Domain Name"
}

variable "acm_certificate_arn" {
  description = "AWS Certificate Manager certificate Amazon Resource Name"
}


