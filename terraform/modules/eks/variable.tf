variable "cluster_name" {
  type = string
  description = "The name of the EKS cluster."
}

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

variable "eks_cluster_role_arn" {
  type = string
  description = "ARN of the EKS cluster IAM role."
}

variable "eks_fargate_role_arn" {
  type = string
  description = "ARN of the EKS Fargate IAM role."
}
