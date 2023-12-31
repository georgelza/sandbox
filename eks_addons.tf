

module "eks_blueprints_kubernetes_addons" {

  source = "aws-ia/eks-blueprints-addons/aws"
  version = "~> 1.0" #ensure to update this to the latest/desired version

  depends_on        = [module.eks.managed_node_groups]

  cluster_name      = module.eks.cluster_name
  cluster_endpoint  = module.eks.cluster_endpoint
  cluster_version   = module.eks.cluster_version
  oidc_provider_arn = module.eks.oidc_provider_arn


  # EKS Managed Add-ons

  enable_aws_load_balancer_controller     = true
  enable_ingress_nginx                    = true

  enable_cluster_proportional_autoscaler  = false
  enable_external_dns                     = false
  enable_metrics_server                   = false
  enable_aws_cloudwatch_metrics           = false
  enable_karpenter                        = false
  enable_kube_prometheus_stack            = false
  enable_cert_manager                     = false

  tags = merge(
    local.tags,
    {
      cluster_name    = local.cluster_name,
      GithubRepo      = "github.com/aws-ia/eks-blueprints-addons/aws",
      Blueprint       = local.name,

    }
  )

}


# module "eks_blueprints_kubernetes_addons" {
#   source = "github.com/aws-ia/terraform-aws-eks-blueprints//modules/kubernetes-addons"

#   eks_cluster_id               = module.eks_blueprints.eks_cluster_id
#   eks_worker_security_group_id = module.eks_blueprints.worker_node_security_group_id
#   auto_scaling_group_names     = module.eks_blueprints.self_managed_node_group_autoscaling_groups
#   depends_on                   = [module.eks_blueprints.managed_node_groups]

#   # EKS Managed Add-ons
#   enable_amazon_eks_vpc_cni            = true
#   enable_amazon_eks_coredns            = true
#   enable_amazon_eks_kube_proxy         = true
#   enable_amazon_eks_aws_ebs_csi_driver = true

#   enable_aws_load_balancer_controller = true
#   enable_ingress_nginx                = true
#   enable_cluster_autoscaler           = true

#   enable_metrics_server               = false
#   enable_prometheus                   = false
#   enable_aws_cloudwatch_metrics       = false

#   tags = local.tags

# }