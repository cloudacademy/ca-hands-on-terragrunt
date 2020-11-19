# Define dependencies on other modules
dependency "vpc" {
  config_path = "../vpc"
}

# Pass data in from a declared dependency
inputs = {
  vpc_id = dependency.vpc.outputs.vpc_id
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}