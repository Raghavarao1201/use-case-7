terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.11.4"
}

data "aws_caller_identity" "current" {}

module "vpc" {
  source = "./modules/vpc"
}

module "iam" {
  source             = "./modules/iam"
  cluster_name       = var.cluster_name
  eks_cluster_oidc_issuer = module.eks.cluster_identity_oidc_issuer
  aws_account_id     = data.aws_caller_identity.current.account_id
}

module "eks" {
  source = "./modules/eks"
  cluster_name = var.cluster_name
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  eks_cluster_role_arn = module.iam.eks_cluster_role_arn
  eks_fargate_role_arn = module.iam.eks_fargate_role_arn
}
