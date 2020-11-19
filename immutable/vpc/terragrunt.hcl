terraform {
  # Deploy version v0.0.1 in prod
  source = "../modules/vpc"
}

inputs = {
  cidr_block = "10.2.0.0/16"
  tags = {
      Environment = "Production"
  }
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}
