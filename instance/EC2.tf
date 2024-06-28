resource "aws_security_group" "teste_breno" {

  name = "teste_breno"

  vpc_id = data.aws_vpc.VPC_DEVELOPMENT.id
  ingress {
    description = "rule for vpn"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [""]
  }

  ingress {
    description = "rule for vpn"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "rule for vpn"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}


resource "aws_instance" "espaco-comunidade" {
  ami                    = "ami-0fbd42f396892566a"
  instance_type          = "t3.large"
  key_name               = "espaco-comunidade"
  vpc_security_group_ids = [aws_security_group.teste_breno.id]
  subnet_id              = data.aws_subnet.DEV_SUBNET_PUBLIC_1.id

  root_block_device {

    volume_size = 15
  }

  tags = {
    Name = "teste_breno"
  }
}
