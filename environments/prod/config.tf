terraform {
  backend "s3" {
    bucket = "group1-prod-terraform-state"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
