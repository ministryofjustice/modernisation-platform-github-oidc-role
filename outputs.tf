output "role" {
  description = "IAM Role created for use by the OIDC provider"
  value       = aws_iam_role.this.arn
}

output "role_trust_policy" {
  description = "Assume role policy for the role"
  value       = data.aws_iam_policy_document.this.json
}

output "role_additional_permissions_policy" {
  description = "Additional role policy for the role"
  value       = try(aws_iam_policy.additional-permissions[0].policy, "")
}