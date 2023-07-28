terraform {
  

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.7.0"
    }
  }
}

locals {
  instance_type   = var.instance_type
  app_server_tags = "APP Server"
}


resource "aws_instance" "my_server" {
  ami = "ami-03f65b8614a860c29"
  #instance_type = "t2.micro"
  instance_type = local.instance_type
  tags = {
    name = "my-server  ${local.app_server_tags}"
  }

}



