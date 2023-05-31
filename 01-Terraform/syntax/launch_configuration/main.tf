provider "aws" {
  region = "ap-northeast-2"
}

# aws 인스턴스 생성 
# aws 시작 구성 생성 
resource "aws_launch_configuration" "example" {
  image_id        = "ami-0c6e5afdd23291f73"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.instance.id]

  user_data = <<-EOF
							#!/bin/bash
							echo "Hello world" > index.html
							nohup busybox httpd -f -p ${var.server_port} &
							EOF


  lifecycle {
    create_before_destroy = true
  }
}

#aws 오토스캐일링 그룹 생성
resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = data.aws_subnets.default.ids
  min_size             = 1
  max_size             = 2

  tag {
    key                 = "Name"
    value               = "aws07-terraform_asg-example"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "instance" {
  name	 = "aws07-terraform-example-instance"
	vpc_id = data.aws_vpc.default.id
  ingress {
	
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_vpc" "default" {
  filter {
		name = "tag:Name"
		values = ["604-vpc"]
	}
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}
variable "server_port" {
  description = "The port will use for HTTP requests"
  type        = number
  default     = 8080
}

