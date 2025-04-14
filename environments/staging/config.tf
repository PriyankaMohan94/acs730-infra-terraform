terraform {
  backend "s3" {
    bucket = "group1-staging-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
