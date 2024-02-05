module "vpc" {
  source = "../vpc"  
}
resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = [module.vpc.subnet_id, module.vpc.public_subnet_id]
}
resource "aws_rds_cluster" "rds-cluster" {
  cluster_identifier      = "rds-cluster"
  engine                  = "aurora-mysql"   # Change to MySQL
  engine_version          = "5.7.12"
  availability_zones      = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]  # Replace with your desired availability zones
  master_username         = "admin"
  master_password         = "xemi1234"  # Replace with a strong password
  port                    = 3306
  storage_encrypted       = true

  skip_final_snapshot       = true  # Set to true if you want to skip the final snapshot
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [module.vpc.security_group_ids]  # Replace with your security group IDs

  scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 1
    seconds_until_auto_pause = 300
  }

  iam_database_authentication_enabled = true
}

resource "aws_rds_cluster_instance" "xemi_instance" {
  identifier          = "xemi-instance"
  cluster_identifier  = aws_rds_cluster.rds-cluster.id
  instance_class      = "db.t2.small"  # Replace with your desired instance type
  engine               = "aurora-mysql" 
  engine_version      = "5.7.12"
  publicly_accessible = false
  
}

resource "aws_db_instance" "rds" {
  identifier           = "rds" 
  engine               =  aws_rds_cluster.rds-cluster.engine
  instance_class       = "db.t2.micro"  
  skip_final_snapshot       = true
 
  allocated_storage    = 20                  
  storage_type         = "gp2"               
  username             = "admin"             
  password             = "password"          
  publicly_accessible  = false      
  db_subnet_group_name = aws_db_subnet_group.default.name

  multi_az             = true  # Enable multi-AZ deployment for clustering
  backup_retention_period = 7  # Set the number of days to retain backups
  engine_version      = aws_rds_cluster.rds-cluster.engine_version
  vpc_security_group_ids = [var.security_group]  # Replace with your security group IDs
  depends_on = [aws_rds_cluster.rds-cluster]
}
