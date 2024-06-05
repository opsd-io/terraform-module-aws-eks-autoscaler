output "cluster_role_arn" {
  description = "The ARN of the IAM role that provides permissions for cluster-autoscaler."
  value       = aws_iam_role.main.arn
}

output "cluster_role_name" {
  description = "The name of the IAM role that provides permissions for cluster-autoscaler."
  value       = aws_iam_role.main.name
}
