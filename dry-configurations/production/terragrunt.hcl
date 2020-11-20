# Generate provider configuration for all child directories
generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.7"
    }
  }
  backend "s3" {}
}

provider "aws" {
  region              = "${local.env_vars.region}" # Local variable from environment_vars.yaml
}
EOF
}

# Remote backend settings for all child directories
remote_state {
  backend = "s3"
  config = {
    bucket         = "ca-tf-state-${get_aws_account_id()}"
    key            = "${local.env_vars.environment}/${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}

# Collect values from environment_vars.yaml and set as local variables
locals {
  env_vars = yamldecode(file("environment_vars.yaml"))

}