variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1"
}
variable "cidr_block" {
  type        = string
  description = ""
  default     = "10.122.0.0/16"
}

variable "subnet_public_az1a" {
  type        = string
  description = ""
  default     = "10.122.18.0/23"
}

variable "subnet_public_az1b" {
  type        = string
  description = ""
  default     = "10.122.20.0/23"
}

variable "subnet_private_app_az1a" {
  type        = string
  description = ""
  default     = "10.122.2.0/23"
}

variable "subnet_private_app_az1b" {
  type        = string
  description = ""
  default     = "10.122.4.0/23"
}

variable "subnet_private_db_az1a" {
  type        = string
  description = ""
  default     = "10.122.10.0/23"
}

variable "subnet_private_db_az1b" {
  type        = string
  description = ""
  default     = "10.122.12.0/23"
}
variable "aws_profile" {
  type        = string
  description = ""
  default     = "dados"
}
variable "aws_account_id" {
  type        = number
  description = ""
  default     = 742364540768
}

variable "service_name" {
  type        = string
  description = ""
  default     = "Network VPC"
}