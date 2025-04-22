# IAM Role for EKS Cluster
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.cluster_name}-cluster-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy_attachment" "eks_cluster_policy_attachment" {
  name       = "${var.cluster_name}-cluster-policy-attachment" 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  roles      = [aws_iam_role.eks_cluster_role.name]
}

resource "aws_iam_policy_attachment" "eks_vpc_cni_policy_attachment" {
  name       = "${var.cluster_name}-vpc-cni-policy-attachment" 
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSCNIPolicy"
  roles      = [aws_iam_role.eks_cluster_role.name] 
}

# IAM Role for Fargate Profiles
resource "aws_iam_role" "eks_fargate_role" {
  name = "${var.cluster_name}-fargate-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_policy_attachment" "eks_fargate_policy_attachment" {
  name       = "${var.cluster_name}-fargate-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  roles      = [aws_iam_role.eks_fargate_role.name]
}
