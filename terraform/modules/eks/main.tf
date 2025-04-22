resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = var.eks_cluster_role_arn
  vpc_config {
    subnet_ids = concat(var.public_subnet_ids, var.private_subnet_ids)
  }
}

resource "aws_security_group" "fargate_sg" {
  name_prefix = "${var.cluster_name}-fargate-sg-"
  vpc_id      = var.vpc_id
 
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
 
  ingress {
    from_port   = 3001
    to_port     = 3001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = {
    Name = "${var.cluster_name}-fargate-sg"
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
