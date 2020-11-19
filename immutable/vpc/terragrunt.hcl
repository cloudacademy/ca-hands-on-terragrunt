terraform {
  # Deploy version v0.0.1 in prod
  source = "../modules/vpc"
}

inputs = {
  cidr_block = local.vpc_cidr
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