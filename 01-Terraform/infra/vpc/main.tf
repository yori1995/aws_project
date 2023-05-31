provider "aws" {
  region = "ap-northeast-2"
}

data "aws_vpc" "default" {
 filter{
	 name = "tag:Name"
	 values = ["604-vpc"]
 }
}

data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_subnet" "example" {
	for_each = toset(data.aws_subnets.example.ids)
	id			 = each.value
}
output "vpc-id" {
  value = data.aws_vpc.default.id
}

output "subnets" {
  value = data.aws_subnets.example.ids
}

output "subnet_cider_blocks" {
	value = [for s in data.aws_subnet.example : s.cidr_block]
# value = values(data.aws_subnet.example)[*].cidr_block 위 내용과 같은것
}
