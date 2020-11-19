terraform {
  # Deploy version v0.0.1 in prod
  source = "../modules/ec2"
}

# Define dependencies on other states with multiple dependency blocks
dependency "vpc" {
  config_path = "../vpc"
}

dependency "network" {
  config_path = "../network"
}

# Pass data in from another dependency
inputs = {
  name = local.servername
  vpc_sg = dependency.vpc.outputs.vpc_sg
  subnet_id = dependency.network.outputs.subnet_id
  num_nodes = local.nodes
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