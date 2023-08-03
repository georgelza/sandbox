output "ec2_lambdabuilder_public_ips" {
  value       = aws_instance.lambdabuilder.*.public_ip
  description = "ec2_lambdabuilder_public_ips "
  sensitive   = false
}

output "ec2_jumpserver_public_ips" {
  value       = aws_instance.jumpserver.*.public_ip
  description = "ec2_jumpserver_public_ips "
  sensitive   = false
}

output "s3_bucket_arn" {
 value       = aws_s3_bucket.terraform_state.arn
 description = "The ARN of the S3 bucket"
}

output "dynamodb_table_name" {
 value       = aws_dynamodb_table.terraform_locks.name
 description = "The name of the DynamoDB table"
}

output "configure_kubectl" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = "aws eks --region ${local.region} update-kubeconfig --name ${module.eks.cluster_name} --profile ${local.profile}"
}