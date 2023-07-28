output "local_server_state" {
  value = aws_instance.my_server.instance_state
}

output "local_server_ip" {
  value = aws_instance.my_server.private_ip
}