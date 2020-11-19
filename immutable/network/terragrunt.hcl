terraform {
  # Deploy version v0.0.1 in prod
  source = "../modules/network"
}

# Define dependencies on other states
dependency "vpc" {
  config_path = "../vpc"
}

# Pass data in from another dependency
inputs = {
  cidr_block = local.subnet_cidr
  availability_zone = local.availability_zone
  vpc_id = dependency.vpc.outputs.vpc_id
  tags = {
      Environment = local.environment
  }
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

locals {
  common_vars = yamldecode(file(find_in_parent_folders("common_vars.yaml")))
}