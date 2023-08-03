locals {
  environment   = var.environment # Environment area eg., preprod or prod
  zone          = var.zone        # Environment with in one sub_tenant or business unit
  region        = var.region
  profile       = var.profile

  vpc_cidr      = var.vpc_cidr
  vpc_name      = var.vpc_name
  azs           = var.azs
  cluster_name  = var.cluster_name
  name          = basename(path.cwd)
  version       = var.versions
  tf_s3_bucket  = var.terraform_s3_bucket

  kubeconfig   = "./kubeconfig"

  # Add merge statement into the various resources to use this + whats required locally.
  tags = {
    
    Owner       = var.owner,
    Workload    = var.project,
    BU          = var.team,
    Environment = var.environment,
    Version     = var.Version,
    Description = var.description,
    map-migrated = "comm138548450576mig45320"


  }

}