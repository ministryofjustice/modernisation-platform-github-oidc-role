
module "module_test" {
  source              = "../../"
  github_repositories = ["ministryofjustice/modernisation-platform-environments", "ministryofjustice/modernisation-platform"]
  role_name           = "modernisation-platform-github-actions"
  policy_arns         = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  policy_jsons        = [data.aws_iam_policy_document.first-policy.json, data.aws_iam_policy_document.second-policy.json]
  tags                = local.tags
}

data "aws_iam_policy_document" "first-policy" {
  #checkov:skip=CKV_AWS_107
  #checkov:skip=CKV_AWS_108
  #checkov:skip=CKV_AWS_109
  #checkov:skip=CKV_AWS_111
  #checkov:skip=CKV_AWS_110
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "account:GetAlternateContact",
      "cur:DescribeReportDefinitions",
      "identitystore:ListGroups",
      "secretsmanager:GetSecretValue",
      "sts:AssumeRole",
      "s3:*",
      "kms:*",
      "iam:*"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "second-policy" {
  #checkov:skip=CKV_AWS_107
  #checkov:skip=CKV_AWS_108
  #checkov:skip=CKV_AWS_109
  #checkov:skip=CKV_AWS_111
  #checkov:skip=CKV_AWS_110
  version = "2012-10-17"
  statement {
    effect = "Deny"
    actions = [
      "iam:ChangePassword",
      "iam:CreateLoginProfile",
      "iam:DeleteUser",
      "iam:DeleteVirtualMFADevice"
    ]
    resources = ["*"]
  }
}