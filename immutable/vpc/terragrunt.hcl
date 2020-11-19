terraform {
  # Deploy version v0.0.1 in prod
  source = "../modules/vpc"
}

inputs = {
  cidr_block = local.env_vars.vpc_cidr
  tags = {
      Environment = local.env_vars.environment
  }
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}


locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}
