module "vpc" {
  source = "./modules/vpc"
}

module "ec2" {
  public_subnet_id = module.vpc.public_subnet_id
  source         = "./modules/ec2"
  vpc_id         = module.vpc.vpc_id
  private_subnet = module.vpc.private_subnet_id
}

module "rds" {
  source            = "./modules/rds"
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet    = module.vpc.private_subnet_id
  security_group = module.vpc.security_group_ids
  
  
  
}


