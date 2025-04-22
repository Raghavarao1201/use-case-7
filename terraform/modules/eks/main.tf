resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn
  vpc_config {
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)
  }
}

resource "aws_eks_fargate_profile" "eks_fargate_profile" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  fargate_profile_name    = "fargate-profile"
  pod_execution_role_arn = var.eks_fargate_role_arn
  subnet_ids   = var.private_subnet_ids

  selector {
    namespace = "default"
  }

  selector {
    namespace = "kube-system"
  }

  depends_on = [aws_eks_cluster.eks_cluster]
}
