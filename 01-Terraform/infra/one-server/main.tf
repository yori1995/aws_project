provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c6e5afdd23291f73"
  instance_type = "t2.micro"

  tags = {
    Name = "aws07-example"
  }
}
