provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
  azs                  = ["us-east-1a", "us-east-1b"]
  project              = "Group1Dev"
}

module "security_group" {
  source  = "../../modules/security-group"
  vpc_id  = module.vpc.vpc_id
  project = "Group1Dev"
module "webservers" {
  source              = "../../modules/webserver"
  instance_count      = 2
  ami_id              = "ami-0c101f26f147fa7fd"
  instance_type       = "t2.micro"
  subnet_ids          = module.vpc.public_subnets
  key_name            = "your-key-name"
  security_group_ids  = [module.security_group.web_sg_id]
  project             = "Group1Dev"
  assign_public_ip    = true
}

module "bastion" {
  source              = "../../modules/webserver"
  instance_count      = 1
  ami_id              = "ami-0c101f26f147fa7fd"
  instance_type       = "t2.micro"
  subnet_ids          = [module.vpc.public_subnets[0]]
  key_name            = "your-key-name"
  security_group_ids  = [module.security_group.web_sg_id]
  project             = "Group1Dev-Bastion"
  assign_public_ip    = true
}