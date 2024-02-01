#!/bin/bash

# Bastion host setup script

# Update and upgrade packages
sudo apt update
sudo apt upgrade -y

# Install necessary packages (e.g., OpenSSH server)
sudo apt install -y openssh-server

# Configure SSH daemon to allow gateway access
sudo echo "AllowTcpForwarding yes" >> /etc/ssh/sshd_config
sudo echo "GatewayPorts yes" >> /etc/ssh/sshd_config
sudo service ssh restart

# Set up user accounts and keys (replace 'your_username' with your actual username)
sudo adduser your_username
sudo usermod -aG sudo your_username

# Copy SSH keys to allow passwordless login (replace 'your_public_key' with your actual public key)
sudo mkdir -p /home/your_username/.ssh
sudo echo "your_public_key" > /home/your_username/.ssh/authorized_keys
sudo chown -R your_username:your_username /home/your_username/.ssh
sudo chmod 700 /home/your_username/.ssh
sudo chmod 600 /home/your_username/.ssh/authorized_keys

# Additional configurations and setup can be added based on your requirements
# For example, setting up a firewall, configuring additional security measures, etc.
