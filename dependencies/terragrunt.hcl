generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents = <<EOF
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.7"
    }
    backend "s3" {}
  }
}

provider "aws" {
  region              = "us-west-2"
}
EOF
}



remote_state {
  backend = "s3"
  config = {
    bucket         = "ca-tf-state-2342231"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-west-2"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}