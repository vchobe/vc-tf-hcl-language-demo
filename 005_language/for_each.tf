resource "aws_instance" "my_server_foreach" {
  
  
  ami = "ami-03f65b8614a860c29"
  
  for_each = {
    nano="t2.nano"
    micro="t2.micro"
  }

  instance_type = each.value
  tags = {
    name = "my-server  ${local.app_server_tags} ${each.key}"
  }

 

}

 output "fe_pub_ip" {
    value = values(aws_instance.my_server_foreach)[*].public_ip

  }
 output "fe_pub_ip1" {
    value = keys(aws_instance.my_server_foreach)[*]

  }
  