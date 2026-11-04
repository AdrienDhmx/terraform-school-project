resource "aws_instance" "ubuntu" {
  ami           = "ami-0d6dd9e8265d48906" # Ubuntu 24.04
  instance_type = var.instance_type
  key_name      = "vockey"

  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  associate_public_ip_address = true


  user_data = file("${path.module}/UserdataScript-phase-2.sh")
  user_data_replace_on_change = true

  tags = {
    Name = "School Ubuntu Instance"
  }
}