variable "aws_region" {
  type = string
  description = "The AWS region to deploy resources in."
  default = "us-east-1"
}

variable "cluster_name" {
  type = string
  description = "The name of the EKS cluster."
  default = "health-eks-cluster"
}
