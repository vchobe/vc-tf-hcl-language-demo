terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
  }
}


provider "aws" {
  profile = "default"
  region  = "us-west-2"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
  alias = "eu_aws"
}

locals {
  instance_type   = var.instance_type
  app_server_tags = "APP Server"
}


variable "instance_type" {
  type = string
  #default = "t2.nano"
}

resource "aws_instance" "my_server" {
  ami = "ami-03f65b8614a860c29"
  #instance_type = "t2.micro"
  instance_type = local.instance_type
  tags = {
    name = "my-server  ${local.app_server_tags}"
  }

}


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  providers = {
    aws=aws.eu_aws
  }
  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}





output "local_server_state" {
  value = aws_instance.my_server.instance_state
}

output "local_server_ip" {
  value = aws_instance.my_server.private_ip
}