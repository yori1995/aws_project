output "vpc_id" {
    value = aws_vpc.aws07_vpc.id
}

output "public_subnet2a" { 
    value = aws_subnet.aws07_public_subnet2a.id
}

output "public_subnet2c" { 
    value = aws_subnet.aws07_public_subnet2c.id
}

output "private_subnet2a" { 
    value = aws_subnet.aws07_private_subnet2a.id
}

output "private_subnet2c" { 
    value = aws_subnet.aws07_private_subnet2c.id
}