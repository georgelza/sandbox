

###### Authentification 

# Used to create the iamzanet sandbox environment
variable "profile" {
  default     = "applab"
  description = "AWS profile to be used used, configured using aws configure --porfile <profile name>"
}


# https://blog.gruntwork.io/how-to-manage-terraform-state-28f5697e68fa
variable "terraform_s3_bucket" {
  default     = "applab-epay-sandbox-state"
  description = "AWS S3 bucket for state file for ePay AppLab Sandbox"
}

variable versions {
  default = "1.27"
  description = "Version of EKS cluster to create"
}

# variable "filedrop_s3_bucket" {
#   default     = "applab-epay-sandbox-filedrop"
#   description = "AWS S3 bucket for state file for ePay AppLab Sandbox - part of a file drop as part of a data ingest"
# }

###### VPC
variable "region" {
  default     = "af-south-1"
  description = "AWS region"
}

variable "azs" {
  default     = ["af-south-1a", "af-south-1b", "af-south-1c", ]
  description = "AWS region"
}

variable "vpc_name" {
  default     = "epay-sandbox-VPC"
  description = "VPC Name"
}

variable "vpc_cidr" {
  default     = "192.168.0.0/16"
  description = "My VPC CIDR lock"
}

###### Project Structure

variable "Version" {
  type        = string
  default     = "1.0"
  description = "Version of deployment"
}

variable "description" {
  type        = string
  default     = "General sandbox used for ePay"
  description = "Description of project"
}

variable "environment" {
  type        = string
  default     = "sandbox"
  description = "Environment area, e.g. prod or preprod, iat, uat, dev or sandbox"
}

variable "project" {
  default     = "tfm"
  description = "Project that owns the environment"
}

# BSA Team under which this falls
variable "team" {
  default     = "Fraud Analytics"
  description = "BSA Team Name"
}

variable "owner" {
  default     = "georgel@bankservafrica.com"
  description = "Who to contact"
}

variable "zone" {
  type        = string
  description = "zone, e.g. dev or qa or load or ops etc..."
  default     = "lab"
}

variable "cluster_name" {
  default     = "epay-lab"
  description = "EKS Cluster Name"
}

variable "create_eks" {
  default     = "false"
  description = "Toggle cluster create true/false"
}


variable "create_app_ng" {
  default     = "false"
  description = "Toggle App Nodegroup create true/false"
}

variable "create_db_ng" {
  default     = "false"
  description = "Toggle DB Nodegroup create true/false"
}




