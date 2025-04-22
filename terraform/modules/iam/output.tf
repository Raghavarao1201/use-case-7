output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
  description = "ARN of the EKS cluster IAM role."
}

output "eks_fargate_role_arn" {
  value = aws_iam_role.eks_fargate_role.arn
  description = "ARN of the EKS Fargate IAM role."
}
