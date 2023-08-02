
# https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class
#
resource "kubernetes_storage_class" "sc_af_south_1" {

  depends_on = [module.eks_blueprints.eks_blueprints_kubernetes_addons]

  metadata {
    name = "zone-af-south-1"
  }
  storage_provisioner = "ebs.csi.aws.com"
  reclaim_policy      = "Delete"
  parameters = {
    fstype    = "ext4"
    encrypted = true # EBS volumes will always be encrypted by default

  }
  allow_volume_expansion = true
  volume_binding_mode    = "Immediate"
  allowed_topologies {
    match_label_expressions {
      key    = "failure-domain.beta.kubernetes.io/zone"
      values = ["af-south-1a", "af-south-1b", "af-south-1c"]

    }
  }
}

########################################################################

#  aws eks update-kubeconfig \
#  --region af-south-1 \
#  --name epay-lab \
#  --profile applab

########################################################################

resource "null_resource" "storageclass_gp2_false" {
  depends_on  = [kubernetes_storage_class.sc_af_south_1]

  provisioner "local-exec" {
    command = "kubectl patch storageclass gp2 -p '{\"metadata\": {\"annotations\":{\"storageclass.kubernetes.io/is-default-class\":\"false\"}}}'"
  }
}

resource "null_resource" "storageclass_sc_af_south_1_true" {
  depends_on  = [null_resource.storageclass_gp2_false]

  provisioner "local-exec" {
    command = "kubectl patch storageclass zone-af-south-1 -p '{\"metadata\": {\"annotations\":{\"storageclass.kubernetes.io/is-default-class\":\"true\"}}}'"
  }
}

resource "null_resource" "get_sc" {
  depends_on  = [null_resource.storageclass_sc_af_south_1_true]

  provisioner "local-exec" {
    command = "kubectl get storageclass"
  }
}

