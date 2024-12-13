# terraform block 
# HCL follow block parameter arrgument format 
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.78.0"
    }
  }
}

# provider block to cconnecrt to aws service 
provider "aws" {
  # Configuration options
    region = "ap-south-1"
}