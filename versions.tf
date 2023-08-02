terraform {
  required_version = ">= 1.1.9"

  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = ">= 4.47"
    }

    kubernetes = {
       source  = "hashicorp/kubernetes"
       version = ">= 2.10"
    }

    helm = {
        source  = "hashicorp/helm"
        version = ">= 2.9"
    }

    # NEWd
    kubectl = {
        source  = "gavinbunney/kubectl"
        version = ">= 1.14.0"
    }

  }

  #Variables are not allowed here !!!
  backend "s3" {
    # Replace this with your bucket name!
    profile = "applab"
    bucket         = "applab-epay-sandbox-state"
    key            = "global/s3/terraform.tfstate"
    region         = "af-south-1"

    # Replace this with your DynamoDB table name!
    dynamodb_table = "applab-epay-sandbox-state"
    encrypt        = true
  }
}