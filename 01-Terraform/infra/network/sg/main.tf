#SSH Security Group
resource "aws_security_group" "aws07_ssh_group"{
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

#WEB Security Group
resource "aws_security_group" "aws07_web_sg"{
    name = "aws07_web_sg"
    description = "security group for web server"
    vpc_id  = data.terraform_remote_state.aws07_vpc.outputs.vpc_id

ingress {
        description    = "For web port"
        from_port   = 80
        to_port     = 80
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
        Name = "aws07_web_sg"
    }
}