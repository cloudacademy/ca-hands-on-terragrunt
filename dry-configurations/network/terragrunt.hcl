# Use remote module for configuration
terraform {
  source = "git::github.com/cloudacademy/terraform-aws-calabmodules.git//network?ref=v0.0.1"
}

# Pass data into remote module with inputs
inputs = {
  cidr_block = local.env_vars.subnet_cidr
  availability_zone = local.env_vars.availability_zone
  vpc_id = dependency.vpc.outputs.vpc_id
  tags = {
      Environment = local.env_vars.environment
  }
}

# Define dependencies on other modules
dependency "vpc" {
  config_path = "../vpc"
}

# Collect values from parent environment_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}