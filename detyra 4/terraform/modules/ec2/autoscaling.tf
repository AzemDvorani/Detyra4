resource "aws_launch_configuration" "example" {
  name = "azemi-launch-configuration"

  # Replace with your preferred AMI and instance type
  image_id        = "ami-030574447f2572780"
  instance_type   = "t2.micro"
  key_name        = "developlmskp"

  user_data = <<-EOF
            #!/bin/bash
            # Your bastion host setup script goes here
            EOF 
            # end of file
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "example" {
  desired_capacity     = 1  // for minimal spent resources
  max_size             = 2
  min_size             = 1
  vpc_zone_identifier = [module.vpc.private_subnet,module.vpc.public_subnet]

  launch_configuration = aws_launch_configuration.example.id
}

module "vpc" {
  source = "../vpc"
}