# Use remote module for configuration
terraform {
  source = "git::github.com/cloudacademy/terraform-aws-calabmodules.git//ec2?ref=v0.0.2"
}

# Pass data into remote module with inputs
inputs = {
  name = local.env_vars.servername
  vpc_sg = dependency.vpc.outputs.vpc_sg
  subnet_id = dependency.network.outputs.subnet_id
  num_nodes = local.env_vars.nodes
  tags = {
      Environment = local.env_vars.environment
  }

}

# Define dependencies on other modules with multiple dependency blocks
dependency "vpc" {
  config_path = "../vpc"
}

dependency "network" {
  config_path = "../network"
}

# Collect values from parent environment_vars.yaml file and set as local variables
locals {
  env_vars = yamldecode(file(find_in_parent_folders("environment_vars.yaml")))
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
