provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c6e5afdd23291f73"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance.id]

  user_data = <<-EOF
							#!/bin/bash
							echo "Hello world" > index.html
							nohup busybox httpd -f -p 8080 &
							EOF

  tags = {
    Name = "aws07-example"
  }
}

resource "aws_security_group" "instance" {
  name = "aws07-terraform-example-instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
	value				= aws_instance.example.public_ip
	description = "The public IP of the Example Instance"
}
