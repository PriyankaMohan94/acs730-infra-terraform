provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source   = "../../modules/vpc"
  vpc_cidr = "10.1.0.0/16"
  public_subnet_cidrs = [
    "10.1.1.0/24", 
    "10.1.2.0/24", 
    "10.1.3.0/24", 
    "10.1.4.0/24"  
  ]
  private_subnet_cidrs = ["10.1.5.0/24", "10.1.6.0/24"]
  azs                  = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
  project              = "Prod"
}

module "security_group" {
  source  = "../../modules/security-group"
  vpc_id  = module.vpc.vpc_id
  project = "Prod"
}


module "webservers" {
  source             = "../../modules/webserver"
  instance_count     = 2
  ami_id             = "ami-0c101f26f147fa7fd"
  instance_type      = "t2.micro"
  subnet_ids         = [module.vpc.public_subnets[0], module.vpc.public_subnets[2]]
  key_name           = "acs730-key"
  security_group_ids = [module.security_group.web_sg_id]
  project            = "ProdWebservers"
  assign_public_ip   = true
}

module "bastion" {
  source             = "../../modules/webserver"
  instance_count     = 1
  ami_id             = "ami-0c101f26f147fa7fd"
  instance_type      = "t2.micro"
  subnet_ids         = [module.vpc.public_subnets[1]]
  key_name           = "acs730-key"
  security_group_ids = [module.security_group.web_sg_id]
  project            = "ProdBastion"
  assign_public_ip   = true
}

module "alb" {
  source            = "../../modules/alb"
  project           = "Prod"
  alb_sg_id         = module.security_group.alb_sg_id
  public_subnet_ids = module.vpc.public_subnets
  vpc_id            = module.vpc.vpc_id
  web_instance_ids  = module.webservers.instance_ids
}
module "webserver4" {
  source             = "../../modules/webserver"
  instance_count     = 1
  ami_id             = "ami-0c101f26f147fa7fd"
  instance_type      = "t2.micro"
  subnet_ids         = [module.vpc.public_subnets[3]]
  key_name           = "acs730-key"
  security_group_ids = [module.security_group.web_sg_id]
  project            = "ProdWebserver4"
  assign_public_ip   = true
}

module "DBserver" {
  source             = "../../modules/webserver"
  instance_count     = 1
  ami_id             = "ami-0c101f26f147fa7fd"
  instance_type      = "t2.micro"
  subnet_ids         = [module.vpc.private_subnets[0]]
  key_name           = "acs730-key"
  security_group_ids = [module.security_group.private_sg_id]
  project            = "ProdWebserver5"
  assign_public_ip   = false
}

module "webserver6" {
  source             = "../../modules/webserver"
  instance_count     = 1
  ami_id             = "ami-0c101f26f147fa7fd"
  instance_type      = "t2.micro"
  subnet_ids         = [module.vpc.private_subnets[1]]
  key_name           = "acs730-key"
  security_group_ids = [module.security_group.private_sg_id]
  project            = "ProdDBserver"
  assign_public_ip   = false
}
