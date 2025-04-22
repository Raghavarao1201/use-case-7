variable "cluster_name" {
  type = string
  description = "The name of the EKS cluster."
}

variable "eks_cluster_oidc_issuer" {
  type        = string
  description = "The OIDC issuer URL of the EKS cluster."
}

variable "aws_account_id" {
  type        = string
  description = "Your AWS account ID."
}