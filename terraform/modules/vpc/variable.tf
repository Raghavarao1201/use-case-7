variable "vpc_id" {
  type = string
  description = "The ID of the VPC."
}

variable "public_subnet_ids" {
  type = list(string)
  description = "A list of public subnet IDs."
}

variable "private_subnet_ids" {
  type = list(string)
  description = "A list of private subnet IDs."
}
