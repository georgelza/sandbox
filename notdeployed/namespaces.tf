
# Lets create the required namespaces

module "monitoring_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "monitoring"
}

module "mongo_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "mongo"
}

module "redis_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "redis_clstr"
}

module "postgres_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "postgres"
}

module "kafka_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "kafka"
}

module "app_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "app"
}

module "binlist_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "binlist"
}

module "cardlist_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "cardlisting"
}

module "dmcs_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "dmcs"
}

module "acmandates_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "acmandates"
}

module "accollections_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "accollections"
}

module "settlement_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "settlement"
}

module "eft_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "eft"
}

module "avsbatch_namespace" {
  source = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name = "avsbatch"
}

#https://thenewstack.io/how-to-use-terraforms-for_each-with-examples/
locals {
  name_spaces = {
    "monitoring_ns"   = { name = "monitoring"},
    "mongo_ns"        = { name = "mongo"},
    "redis_clstr_ns"  = { name = "redis_clstr"},
    "postgres_ns"     = { name = "postgres"},
    "kafka_ns"        = { name = "kafka"},
    "app_ns"          = { name = "app"},
    "binlist_ns"      = { name = "binlist"},
    "cardlisting_ns"  = { name = "cardlisting"},
    "dmcs_ns"         = { name = "dmcs"},
    "acmandates_ns"   = { name = "acmandates"},
    "accollections_ns"  = { name = "accollections"},
    "settlement_ns"   = { name = "settlement"},
    "eft_ns"          = { name = "eft"},
    "avsbatch_ns"     = { name = "avsbatch"}
 }
}
 
resource "create_namespace" {
for_each = local.name_spaces
  source  = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name    = each.value.name
}