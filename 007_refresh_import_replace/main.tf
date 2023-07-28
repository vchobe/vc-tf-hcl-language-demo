terraform {
  
  backend "s3" {
    bucket = "vc-tf01-remote-state"
    encrypt = true
    region = "us_east_1"
  }

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



locals {
  instance_type   = var.instance_type
  app_server_tags = "APP Server"
}


variable "instance_type" {
  type = string
  default = "t2.small"
}

resource "aws_instance" "my_server" {
  ami = "ami-03f65b8614a860c29"
  #instance_type = "t2.micro"
  instance_type = local.instance_type
  tags = {
    name = "my-server  ${local.app_server_tags}"
  }

}



/* resource "aws_instance" "my_aws_server" {
  instance_type = "t2.nano"
  ami = "ami-0744bdf45532dfd8e"
  
  

} */

/* data "terraform_remote_state" "var_remote"{
Hi 
} */




output "local_server_state" {
  value = aws_instance.my_server.instance_state
}

output "local_server_ip" {
  value = aws_instance.my_server.private_ip
}