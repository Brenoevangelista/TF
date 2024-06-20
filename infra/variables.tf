# variables.tf

variable "aws_region" {
  description = "The AWS region things are created in"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
}

variable "ecs_auto_scale_role_name" {
  description = "ECS auto scale role name"
}

variable "az_count" {
  description = "Number of AZs to cover in a given region"
}

variable "app_image" {
  description = "Docker image to run in the ECS cluster"
}

variable "app_port" {
  description = "Port exposed by the docker image to redirect traffic to"
}

variable "app_count" {
  description = "Number of docker containers to run"
}

variable "health_check_path" {
  default = "/"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
}

variable "aws_profile" {
  description = "Profile AWS account"
}

variable "aws_account_id" {
  description = "ID AWS account"
}

variable "vpc_id" {
  description = "ID of VPC"
}

variable "ecr_repository" {
  description = "ID of VPC"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public Subnet CIDR values"
  default     = []
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnet CIDR values"
  default     = []
}

variable "tags" {
  description = "AWS Tags to add to all resources created (where possible); see https://aws.amazon.com/answers/account-management/aws-tagging-strategies/"
  type        = map(any)
  default     = {}
}

variable "redis_cluster_id" {
  description = "The ID of the Redis cluster"
  type        = string
}

variable "redis_node_type" {
  description = "The instance type for the Redis cluster nodes"
  type        = string
}

variable "redis_engine_version" {
  description = "The version of Redis to use"
  type        = string
}

variable "redis_num_cache_nodes" {
  description = "The number of cache nodes in the Redis cluster"
  type        = number
}

variable "redis_parameter_group_name" {
  description = "The name of the parameter group to use for the Redis cluster"
  type        = string
  default     = "default.redis6.x"
}