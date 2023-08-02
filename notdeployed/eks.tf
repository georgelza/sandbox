
# https://github.com/aws-ia/terraform-aws-eks-blueprints




#---------------------------------------------------------------
# Example to consume eks_blueprints module
#---------------------------------------------------------------
# terraform destroy -auto-approve -target="module.eks_blueprints"
module "eks" {
  //source = "github.com/aws-ia/terraform-aws-eks-blueprints"
  source  = "terraform-aws-modules/eks/aws"
  
  version = "~> 19.13"

  # EKS CONTROL PLANE VARIABLES
  cluster_name    = local.cluster_name
  cluster_version = local.version

  cluster_addons = {
    coredns    = {}
    kube-proxy = {}
    vpc-cni = {
      # Specify the VPC CNI addon should be deployed before compute to ensure
      # the addon is configured before data plane compute resources are created
      # See README for further details
      before_compute = true
      most_recent    = true # To ensure access to the latest settings provided
      configuration_values = jsonencode({
        env = {
          # Reference https://aws.github.io/aws-eks-best-practices/reliability/docs/networkmanagement/#cni-custom-networking
          AWS_VPC_K8S_CNI_CUSTOM_NETWORK_CFG = "true"
          ENI_CONFIG_LABEL_DEF               = "topology.kubernetes.io/zone"

          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

  vpc_id      = aws_vpc.main.id

  # This links into resource based vpc/subnets/natgw/igw etc
  subnet_ids = [
    # The Web interface layer / ip's subnets, this is where the nginx/LB lives
    aws_subnet.public_1.id, # 192.168.11.0/24
    aws_subnet.public_2.id, # 192.168.12.0/24
    aws_subnet.public_3.id, # 192.168.13.0/24

    # APP EKS - Application pods with live on nodegroups located on these subnets
    aws_subnet.private_1.id, # 192.168.21.0/24
    aws_subnet.private_2.id, # 192.168.22.0/24
    aws_subnet.private_3.id, # 192.168.23.0/24

    # DB EKS - databse pods with live on nodegroups located on these subnets
    aws_subnet.private_4.id, # 192.168.31.0/24
    aws_subnet.private_5.id, # 192.168.32.0/24
    aws_subnet.private_6.id, # 192.168.33.0/24
    
    # Management EKS - Managment Tooling pods with live on nodegroups located on these subnets
    aws_subnet.private_7.id, # 192.168.41.0/24
    aws_subnet.private_8.id, # 192.168.42.0/24
    aws_subnet.private_9.id, # 192.168.43.0/24
  ]

  control_plane_subnet_ids = [
    aws_subnet.private_c1.id, # 192.168.111.0/24
    aws_subnet.private_c2.id, # 192.168.112.0/24
    aws_subnet.private_c3.id, # 192.168.113.0/24
  ]

  # A map of tags to assign to the resource.
  tags = merge(
    local.tags,
    {
      cluster_name    = local.cluster_name
    }
  )

  ############################
  # EKS MANAGED NODE GROUPS
  ############################

  eks_managed_node_groups = {

    # app_ng
    app_ng = {
      node_group_name = "app_ng"
      instance_types  = ["t3.medium"]
      ami_type        = "AL2_x86_64" # Available options -> AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM

      desired_size = 3 # Node Group scaling configuration
      max_size     = 9
      min_size     = 3

      capacity_type = "ON_DEMAND" # ON_DEMAND or SPOT
      disk_size     = 20          # Disk size in GiB for worker nodes

      # Node Group network configuration
      subnet_ids = [
        # APP EKS
        aws_subnet.private_1.id, # 192.168.21.0/24
        aws_subnet.private_2.id, # 192.168.22.0/24
        aws_subnet.private_3.id, # 192.168.23.0/24
      ]

      # Node Labels can be applied through EKS API or through Bootstrap script using kubelet_extra_args
      k8s_labels = {
        tier = "app"
      }

      # SSH ACCESS Optional - Recommended to use SSM Session manager
      #      remote_access         = true
      #      ec2_ssh_key           = aws_key_pair.my-pub-key.id
      #      ssh_security_group_id = [aws_security_group.sg_management_ssh.id]

      # A map of tags to assign to the resource.
      additional_tags = merge(
        local.tags,
        {
          subnet_type = "private"

        },
      )
    },


    /*db_ng = {
      node_group_name = "db_ng"
      instance_types  = ["t3.large"]
      ami_type        = "AL2_x86_64" # Available options -> AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64, CUSTOM

      desired_size = 6 # Node Group scaling configuration
      max_size     = 12
      min_size     = 6

      capacity_type = "ON_DEMAND" # ON_DEMAND or SPOT
      disk_size     = 20          # Disk size in GiB for worker nodes

      # Node Group network configuration
      subnet_ids = [
        # APP EKS
        aws_subnet.private_4.id, # 192.168.31.0/24
        aws_subnet.private_5.id, # 192.168.32.0/24
        aws_subnet.private_6.id, # 192.168.33.0/24
      ]

      # Node Labels can be applied through EKS API or through Bootstrap script using kubelet_extra_args
      k8s_labels = {
        tier = "db"
      }

      # SSH ACCESS Optional - Recommended to use SSM Session manager
      #      remote_access         = true
      #      ec2_ssh_key           = aws_key_pair.my-pub-key.id
      #      ssh_security_group_id = [aws_security_group.sg_management_ssh.id]

      # A map of tags to assign to the resource.
      additional_tags = merge(
        local.tags,
        {
          subnet_type = "private"

        },
      )
    }
    */
    # man_ng

  }
}

# output "eks_cluster_id" {
#   description = "EKS cluster ID"
#   value       = module.eks_blueprints.eks_cluster_id
# }


# aws eks update-kubeconfig \
#--region af-south-1 \
#--name epay-lab \
#--profile applab