provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "cloud_api" {
  ami                    = "ami-0faab6bdbac9486fb" # Ubuntu 22.04 LTS in eu-central-1
  instance_type          = "t2.micro"
  key_name               = var.key_name # Previously created on the cloud for simplicity
  associate_public_ip_address = true

  user_data              = file("user_data.sh")

  vpc_security_group_ids = [aws_security_group.api_sg.id]

  tags = {
    Name = "cloud-api-instance"
  }
}

resource "aws_security_group" "api_sg" {
  name        = "cloud-api-sg"
  description = "Allow SSH and API access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Could be restricted but I left it open for demo purposes
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8404
    to_port     = 8404
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 6000
    to_port     = 6000
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
