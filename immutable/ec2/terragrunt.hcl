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
  name = "webserver"
  vpc_sg = dependency.vpc.outputs.vpc_sg
  subnet_id = dependency.network.outputs.subnet_id
  num_nodes = 1
  tags = {
      Environment = "Production"
  }

}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}