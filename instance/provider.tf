terraform {
  backend "s3" {
    bucket = "sld-tf-app-states-stg"
    key    = "espaco_comunidade_tf"
    region = "us-east-1"
  }

  required_providers {
    aws = "4.67.0"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

