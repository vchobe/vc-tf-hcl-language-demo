
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

data "aws_ami" "ubantu_ami" {
  most_recent = true
  filter {
    name="name"
    values=["SUSE Linux Enterprise Server 12 SP5 (HVM), SSD Volume Type"]

  }

}


variable "instance_type" {
  type = string
  #default = "t2.nano"
}

variable "scope" {
  type = string
  validation {
    condition = can(length(var.scope)==3)
    error_message = "length should be more than 3"
  }
}

variable "creds" {
  type = string
  sensitive = true
  description = "CREDS"
  default = "value"
}

resource "aws_instance" "my_server" {
  #ami = "ami-03f65b8614a860c29"
  ami = data.aws_ami.ubantu_ami.id
  #instance_type = "t2.micro"
  instance_type = local.instance_type
  tags = {
    name = "my-server  ${local.app_server_tags}"
    scope=var.scope
  }

}

output "local_server_state" {
  value = aws_instance.my_server.instance_state
}

output "local_server_ip" {
  value = aws_instance.my_server.private_ip
}


