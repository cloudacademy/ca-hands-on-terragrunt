terraform {
  # Deploy version v0.0.1 in prod
  source = "git::git@github.com:cloudacademy/terraform-aws-calabmodules.git//ec2?ref=v0.0.1"
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
  name = local.env_vars.servername
  vpc_sg = dependency.vpc.outputs.vpc_sg
  subnet_id = dependency.network.outputs.subnet_id
  num_nodes = local.env_vars.nodes
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