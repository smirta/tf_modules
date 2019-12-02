output "showCIDR" {
  value = aws_subnet.main-subnet.cidr_block
}

output "main-vpc-id" {
  aws_vpc.main-vpc.id
}
