resource "aws_instance" "aws07_bastion" {
    ami = data.aws_ami.ubuntu.image_id
    instance_type = "t2.micro"
    key_name = "aws07-key"
    #보안그룹
    vpc_security_group_ids = [aws_security_group.aws07_ssh_sg.id]
    #서브넷
    subnet_id = data.terraform_remote_state.aws07_vpc.outputs.public_subnet2a
    #가용영역
    availability_zone = "ap-northeast-2a"
    #퍼블릭 ip 할당 여부
    associate_public_ip_address = true

    tags = {
        Name = "aws07-bastion"
    }
}

resource "aws_security_group" "aws07_ssh_sg" {
    name = "aws07_ssh_sg"
    description = "security group for ssh server"
    vpc_id  = data.terraform_remote_state.aws07_vpc.outputs.vpc_id

ingress {
        description    = "For ssh port"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        protocol    = "-1"
        from_port   = 0
        to_port     = 0
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    tags = {
        Name = "aws07_ssh_sg"
    }
}