#------------vpc---------------------------------------
resource "aws_vpc" "aws07_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
  instance_tenancy = "default"

  tags = {
    Name = "aws07_vpc"
  }
}

 #-------------------서브넷----------------------------------
 #퍼블릭 서브넷 2a
 resource "aws_subnet" "aws07_public_subnet2a" {
    vpc_id = aws_vpc.aws07_vpc.id
    cidr_block = var.public_subnet[0]
    availability_zone = var.azs[0]

    tags = {
      Name = "aws07_public_subnet2a"
    }  
}

#퍼블릭 서브넷 2c
 resource "aws_subnet" "aws07_public_subnet2c" {
    vpc_id = aws_vpc.aws07_vpc.id
    cidr_block = var.public_subnet[1]
    availability_zone = var.azs[1]

    tags = {
      Name = "aws07_public_subnet2c"
    }  
}

#프라이빗 서브넷 2a
 resource "aws_subnet" "aws07_private_subnet2a" {
    vpc_id = aws_vpc.aws07_vpc.id
    cidr_block = var.private_subnet[0]
    availability_zone = var.azs[0]

    tags = {
      Name = "aws07_private_subnet2a"
    }  
}

#프라이빗 서브넷 2c
 resource "aws_subnet" "aws07_private_subnet2c" {
    vpc_id = aws_vpc.aws07_vpc.id
    cidr_block = var.private_subnet[1]
    availability_zone = var.azs[1]

    tags = {
      Name = "aws07_private_subnet2c"
    }  
}

#---------------internet gateway----------------------------
resource "aws_internet_gateway" "aws07_igw"{
  vpc_id = aws_vpc.aws07_vpc.id

  tags = {
    Name = "aws07_Internet-gateway"
  }
}

#-------------------- NAT gateway ------------------------------
#EIP(elastic IP탄력적) for NAT gateway

resource "aws_eip" "aws07_eip" {
  vpc = true
  depends_on = [ "aws_internet_gateway.aws07_igw" ]
  lifecycle {
    create_before_destroy = true
  }
}

#NAT gateway
resource "aws_nat_gateway" "aws07_nat" {
  allocation_id = aws_eip.aws07_eip.id
  #NAT를 생성할 서브넷 위치
  subnet_id = aws_subnet.aws07_public_subnet2a.id
  depends_on = [ "aws_internet_gateway.aws07_igw" ]
}

#AWS에서 vpc를 생성하면 자동으로 route table이 하나 생긴다.
#aws_default_route_table은 route table을 만들지 않고 vpc가 만든
#기본 route table을 가져와서 terraform이 관리할 수 있게 한다.
resource "aws_default_route_table" "aws07_public_rt" {
  default_route_table_id = aws_vpc.aws07_vpc.default_route_table_id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.aws07_igw.id
  }
  tags = {
    Name = "aws07 public route table"
  }
}

#디폴트 라우터를 퍼블릭 서브넷에 연결
resource "aws_route_table_association" "aws07_public_rta_2a" {
  subnet_id =aws_subnet.aws07_public_subnet2a.id
  route_table_id = aws_default_route_table.aws07_public_rt.id
}

resource "aws_route_table_association" "aws07_public_rta_2c" {
  subnet_id =aws_subnet.aws07_public_subnet2c.id
  route_table_id = aws_default_route_table.aws07_public_rt.id
}

#프라이빗 라우트 생성 및 프라이빗 서브넷에 연결
resource "aws_route_table" "aws07_private_rt"{
  vpc_id = aws_vpc.aws07_vpc.id
  tags = {
    Name = "aws07 private route table"
  }
}

resource "aws_route_table_association" "aws07_private_rta_2a" {
  subnet_id =aws_subnet.aws07_private_subnet2a.id
  route_table_id = aws_route_table.aws07_private_rt.id
}

resource "aws_route_table_association" "aws07_private_rta_2c" {
  subnet_id =aws_subnet.aws07_private_subnet2c.id
  route_table_id = aws_route_table.aws07_private_rt.id
}

resource "aws_route" "aws07_private_rt_table" {
  route_table_id = aws_route_table.aws07_private_rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.aws07_nat.id
}