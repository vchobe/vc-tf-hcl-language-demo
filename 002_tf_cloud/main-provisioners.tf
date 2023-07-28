
resource "aws_instance" "my_server1" {
  ami = "ami-03f65b8614a860c29"
  #instance_type = "t2.micro"
  instance_type = local.instance_type
  tags = {
    name = "my-server  ${local.app_server_tags}"
  }
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
   # interpreter = [ "PowerShell","-Command" ]

  }
  provisioner "file" {
    source = ""
    destination = ""
    connection {
      type="ssh"
      user="root"
      password = ""
      host=""  
    }
  }
}

resource "aws_instance" "my_server2" {
  ami = "ami-03f65b8614a860c29"
  #instance_type = "t2.micro"
  instance_type = local.instance_type
  tags = {
    name = "my-server  ${local.app_server_tags}"
  }
  provisioner "remote-exec" {
    scripts = [ "./setup-user.sh",
                "/home/user1/bootstrap"]      

  }
}