#!/bin/bash

# Terraform initialization script
terraform init -backend-config="bucket=your-terraform-state-bucket-name" -backend-config="key=terraform.tfstate"
