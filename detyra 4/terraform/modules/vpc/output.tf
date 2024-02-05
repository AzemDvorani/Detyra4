output "public_subnet_id" {
    value = aws_subnet.public_subnet_id.id/// e kom shtu per test
  
}
output "vpc_id" {
    value = aws_vpc.my_vpc.id   //per me dit id e vpc se.
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
}
output "subnet_id" {
  value = aws_subnet.private_subnet.id
}

output "security_group_ids" {
  value = aws_security_group.xemi_security_group.id
}
