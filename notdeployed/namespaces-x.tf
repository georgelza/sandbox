
#https://thenewstack.io/how-to-use-terraforms-for_each-with-examples/
locals {
  namespaces = {
    "monitoring-ns"   = { name = "monitoring"},
    "mongo-ns"        = { name = "mongo"},
    "redis-clstr-ns"  = { name = "redisclstr"},
    "postgres-ns"     = { name = "postgres"},
    "app-ns"          = { name = "app"}
    }
}
 
module "create_namespace" {
for_each = local.namespaces
  source  = "git::https://github.com/gruntwork-io/terraform-kubernetes-namespace.git//modules/namespace?ref=v0.1.0"
  name    = each.value["name"]
}