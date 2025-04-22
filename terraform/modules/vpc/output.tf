output "vpc_id" {
  value = aws_vpc.test_vpc.id
  description = "The ID of the VPC."
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id,
  ]
  description = "A list of public subnet IDs."
}

output "private_subnet_ids" {
  value = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
  ]
  description = "A list of private subnet IDs."
}