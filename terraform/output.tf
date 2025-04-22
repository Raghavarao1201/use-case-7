output "vpc_id" {
  value = module.vpc.vpc_id
  description = "The ID of the VPC."
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
  description = "A list of public subnet IDs."
}

output "private_subnet_ids" {
  value = module.vpc.private_subnet_ids
  description = "A list of private subnet IDs."
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
  description = "The name of the EKS cluster."
}

output "kubeconfig" {
  value = module.eks.kubeconfig
  sensitive = true
  description = "Kubernetes configuration to access the EKS cluster."
}
