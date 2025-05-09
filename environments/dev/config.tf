terraform {
required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  backend "s3" {
    bucket = "group1-dev-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
