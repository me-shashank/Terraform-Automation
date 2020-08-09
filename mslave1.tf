


resource "aws_instance" "slave1" {
  ami                         = "ami-05695932c5299858a"
  instance_type               = "t2.micro"
  vpc_security_group_ids      = ["sg-0949da4b578f50bc3"]
  subnet_id                   = "subnet-0928ea13487a036f0"
  associate_public_ip_address = "1"
  user_data                   = "${file("slave.sh")}"
  key_name                    = "key"
  tags = {
    Name = "Slave-1"
  }
}
