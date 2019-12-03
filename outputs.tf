output "showCIDR" {
  value = aws_subnet.main-subnet.cidr_block
}

output "main-subnet-id" {
  value = aws_subnet.main-subnet.id
}

output "main-vpc-id" {
  value = aws_vpc.main-vpc.id
}
