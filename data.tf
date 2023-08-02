data aws_region current {}

# data aws_eks_cluster cluster {
#   name = module.eks_blueprints.eks_cluster_id
# }

# data aws_eks_cluster_auth cluster {
#   name = module.eks_blueprints.eks_cluster_id
# }

data "aws_availability_zones" "available" {}

data "template_file" "terraform_state_bucket_policy" {
  template = file("${path.module}/policies/terraform_state_bucket_policy.json")

  vars = {
    bucket_name              = aws_s3_bucket.terraform_state.id
    current_account          = "383982001916"
  }
}