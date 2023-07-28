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
  default = "t2.nano"
}

resource "aws_instance" "my_server" {
  count = 2

  tags = {
    name = "my-server  ${local.app_server_tags} ${count.index}"
  }

  ami = "ami-03f65b8614a860c29"
  instance_type = local.instance_type
  

}





output "local_server_state" {
  value = aws_instance.my_server[*].instance_state
}

output "local_server_ip" {
  value = aws_instance.my_server[*].private_ip
}