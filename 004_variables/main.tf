terraform {
  
}

locals {
  scope="sub-local"
  instanceType="t2.nano"
}


module "aws_server" {
  source = ".//var_submodule"
  instance_type = "t2.nano"
  scope = "submodule"
}

output "local_server_state" {
  value = module.aws_server.local_server_state
}

output "local_server_ip" {
  value = module.aws_server.local_server_ip
  
}