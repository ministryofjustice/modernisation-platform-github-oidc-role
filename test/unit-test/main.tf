
module "module_test" {
  #checkov:skip=CKV_AWS_274
  #checkov:skip=CKV_AWS_358
  source              = "../../"
  github_repositories = ["ministryofjustice/modernisation-platform-environments", "ministryofjustice/modernisation-platform"]
  role_name           = "modernisation-platform-github-actions"
  policy_arns         = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  policy_jsons        = [data.aws_iam_policy_document.first-policy.json, data.aws_iam_policy_document.second-policy.json]
  tags                = local.tags
}

module "module_test_with_subject_claim" {
  #checkov:skip=CKV_AWS_274
  #checkov:skip=CKV_AWS_358
  source              = "../../"
  github_repositories = ["ministryofjustice/modernisation-platform-environments", "ministryofjustice/modernisation-platform"]
  role_name           = "modernisation-platform-github-actions-with-claim"
  policy_arns         = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  policy_jsons        = [data.aws_iam_policy_document.first-policy.json, data.aws_iam_policy_document.second-policy.json]
  subject_claim       = "pull_request"
  tags                = local.tags
}

data "aws_iam_policy_document" "first-policy" {
  #checkov:skip=CKV_AWS_107
  #checkov:skip=CKV_AWS_108
  #checkov:skip=CKV_AWS_109
  #checkov:skip=CKV_AWS_111
  #checkov:skip=CKV_AWS_110
  #checkov:skip=CKV_AWS_356
  #checkov:skip=CKV2_AWS_40
  version = "2012-10-17"

  statement {
    effect = "Allow"
    actions = [
      "account:GetAlternateContact",
      "cur:DescribeReportDefinitions",
      "identitystore:ListGroups",
      "secretsmanager:GetSecretValue",
      "sts:AssumeRole",
      "s3:GetObject",
      "s3:PutObject",
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