
# https://github.com/aws-ia/terraform-aws-eks-blueprints

module "eks_blueprints_kubernetes_addons" {
  source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons"

  eks_cluster_id               = module.eks_blueprints.eks_cluster_id
  eks_worker_security_group_id = module.eks_blueprints.worker_node_security_group_id
  auto_scaling_group_names     = module.eks_blueprints.self_managed_node_group_autoscaling_groups
  depends_on                   = [module.eks_blueprints.managed_node_groups]

  # EKS Managed Add-ons
  enable_amazon_eks_vpc_cni            = true
  enable_amazon_eks_coredns            = true
  enable_amazon_eks_kube_proxy         = true
  enable_amazon_eks_aws_ebs_csi_driver = true

  enable_aws_load_balancer_controller = true
  enable_ingress_nginx                = true
  enable_cluster_autoscaler           = true

  enable_metrics_server               = false
  enable_prometheus                   = false
  enable_aws_cloudwatch_metrics       = false

  tags = local.tags

}
