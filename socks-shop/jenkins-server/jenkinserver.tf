## Create a jenkinserver

resource "aws_instance" "jenkin-server" {
  count = 1  
  ami                         = data.aws_ami.latest-amazon-linux-image.id
  instance_type               = var.instance_type
  key_name                    = "newkey-e1"
  subnet_id      = aws_subnet.socks-shop[count.index].id
  vpc_security_group_ids      = [aws_default_security_group.socks-shop-sg.id]
  availability_zone           = var.availabilty_zone
  associate_public_ip_address = true
  user_data                   = file("server-script.sh")
}

data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}