output "vpc_id" {
  value = var.vpc_id
  description = "The ID of the VPC."
}

output "public_subnet_ids" {
  value = var.public_subnet_ids
  description = "A list of public subnet IDs."
}

output "private_subnet_ids" {
  value = var.private_subnet_ids
  description = "A list of private subnet IDs."
}
