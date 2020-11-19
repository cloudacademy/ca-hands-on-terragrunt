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
  cidr_block = "10.2.0.0/24"
  availability_zone = "us-west-2a"
  vpc_id = dependency.vpc.outputs.vpc_id
  tags = {
      Environment = "Production"
  }
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}