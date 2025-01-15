# Created an user in AWS and configure it in AWS CLI
# Then used this script to create a VPC

provider "aws" {
    region = "eu-west-2"
}

resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
  
}