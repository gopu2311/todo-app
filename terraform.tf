provider "aws" {
  region = "eu-north-1"
}
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = file("~/.ssh/id_ed25519.pub") 
}

resource "aws_security_group" "todo_app_sg" {
  name        = "todo-app-sg"
  description = "Allow SSH, HTTP (8080), and custom port 5000"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "App Port 5000"
    from_port   = 5000
    to_port     = 5000
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
resource "aws_instance" "todo_app" {
  ami                         = "ami-0c55b159cbfafe1f0" 
  instance_type               = "t3.small"
  key_name                    = aws_key_pair.deployer.key_name
  vpc_security_group_ids      = [aws_security_group.todo_sg.id]
  associate_public_ip_address = true
  
  tags = {
    Name = "todo-app-instance"
  }
}
  

