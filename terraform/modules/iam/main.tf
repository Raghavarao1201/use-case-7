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
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
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

# IAM Role for the Kubernetes Service Account to Pull from ECR
resource "aws_iam_role" "ecr_puller_sa_role" {
  name = "${var.cluster_name}-ecr-sa-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          AWS = aws_iam_role.eks_fargate_role.arn
        },
        Action = "sts:AssumeRole",
        Condition = {}
      }
    ]
  })

  tags = {
    Name = "${var.cluster_name}-ecr-sa-role"
  }
}

# Attach AmazonECRReadOnly policy to the Service Account Role
resource "aws_iam_policy_attachment" "ecr_puller_sa_policy_attachment" {
  name       = "${var.cluster_name}-ecr-sa-policy-attachment"
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  roles      = [aws_iam_role.ecr_puller_sa_role.name]
}