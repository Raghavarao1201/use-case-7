output "cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
  description = "The name of the EKS cluster."
}

output "kubeconfig" {
  value = aws_eks_cluster.eks_cluster.endpoint == "" ? "" : <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks_cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks_cluster.certificate_authority.0.data}
  name: ${aws_eks_cluster.eks_cluster.name}
contexts:
- context:
    cluster: ${aws_eks_cluster.eks_cluster.name}
    user: aws
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1beta1
      command: aws
      args:
        - "eks"
        - "get-token"
        - "--cluster-name"
        - "${aws_eks_cluster.eks_cluster.name}"
#        - "--role-arn" # Add if you are assuming a role
      env: {}
KUBECONFIG
  sensitive = true
  description = "Kubernetes configuration to access the EKS cluster."
}
