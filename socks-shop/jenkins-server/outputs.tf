output "ec2_public_ip" {
  value = aws_instance.jenkin-server.*.public_ip

}