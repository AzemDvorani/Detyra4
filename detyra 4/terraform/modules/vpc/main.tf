resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16" //ip avaliable for this ....

  enable_dns_support = true
  enable_dns_hostnames = true
}
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"  
  availability_zone       = "eu-central-1a"   
  map_public_ip_on_launch = true

  tags = {
    Name = "Public_Subnet"  # Replace with your desired name
  }
}
resource "aws_subnet" "private_subnet" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"  
  availability_zone       = "eu-central-1b"   
  tags = {
    Name = "Private_Subnet"  # Replace with your desired name
  }
}
resource "aws_security_group" "xemi_security_group" {
  name        = "xemi_security_group"
  description = "Security Group for RDS"
  vpc_id = aws_vpc.my_vpc.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Adjust as per your network requirements
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow outbound traffic to anywhere
  }
}

output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "public_subnet" {
  value = aws_subnet.public_subnet.id
}
output "private_subnet" {
  value = aws_subnet.private_subnet.id
}

output "subnet_id" {
  value = aws_subnet.private_subnet.id
}
output "security_group" {
  value = aws_security_group.xemi_security_group.id
   
}
