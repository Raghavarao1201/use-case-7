resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn
  vpc_config {
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
    aws_iam_role_policy_attachment.eks_vpc_cni_policy_attachment,
  ]
}

resource "aws_eks_fargate_profile" "eks_fargate_profile" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  name_prefix  = "fargate"
  pod_execution_role_arn = var.eks_fargate_role_arn
  subnet_ids   = var.private_subnet_ids # Fargate pods typically run in private subnets

  selector {
    namespace = "default"
  }

  selector {
    namespace = "kube-system"
  }

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_iam_role_policy_attachment.eks_fargate_policy_attachment,
  ]
}
