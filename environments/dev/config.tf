terraform {
  backend "s3" {
    bucket = "group1-dev-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
