
variable "vpc_id" {
  description = "ID of the VPC"
}

variable "public_subnet" {
  description = "ID of the public subnet"
}

variable "private_subnet" {
  description = "ID of the private subnet"
}


resource "aws_instance" "bastion" {
  ami           = "ami-030574447f2572780"  # Replace with the correct AMI ID
  instance_type = "t2.micro"
  key_name      = "developlmskp"            # Replace with your key pair name
  subnet_id     = var.public_subnet

  user_data = <<-EOF
               #!/bin/bash
               # Your bastion host setup script goes here
               EOF
}
output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}