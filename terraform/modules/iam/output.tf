output "eks_cluster_role_arn" {
  value = aws_iam_role.eks_cluster_role.arn
  description = "ARN of the EKS cluster IAM role."
}

output "eks_fargate_role_arn" {
  value = aws_iam_role.eks_fargate_role.arn
  description = "ARN of the EKS Fargate IAM role."
}

output "ecr_puller_sa_role_arn" {
  value       = aws_iam_role.ecr_puller_sa_role.arn
  description = "ARN of the IAM role for the Kubernetes Service Account to pull from ECR."
}

