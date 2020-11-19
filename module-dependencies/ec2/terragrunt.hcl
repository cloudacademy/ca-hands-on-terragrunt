# Define dependencies on other states with multiple dependency blocks
dependency "vpc" {
  config_path = "../vpc"
}

dependency "network" {
  config_path = "../network"
}

# Pass data in from another dependency
inputs = {
  vpc_sg = dependency.vpc.outputs.vpc_sg
  subnet_id = dependency.network.outputs.subnet_id
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}