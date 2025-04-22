terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" n
}

module "vpc" {
  source = "./modules/vpc"
  vpc_id = aws_vpc.test_vpc.id
  public_subnet_ids = [
    aws_subnet.public_subnet_1.id,
    aws_subnet.public_subnet_2.id,
  ]
  private_subnet_ids = [
    aws_subnet.private_subnet_1.id,
    aws_subnet.private_subnet_2.id,
  ]
}

module "iam" {
  source = "./modules/iam"
  cluster_name = "my-eks-cluster" # You can change this
}

module "eks" {
  source = "./modules/eks"
  cluster_name = module.iam.cluster_name
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_fargate_role_arn = module.iam.eks_fargate_role_arn
}
