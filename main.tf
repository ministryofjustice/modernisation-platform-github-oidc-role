
resource "aws_iam_role" "this" {
  name               = var.role_name
  assume_role_policy = data.aws_iam_policy_document.this.json
  tags               = var.tags
}

data "aws_iam_policy_document" "this" {
  version = "2012-10-17"

  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = formatlist("repo:%s:*", var.github_repositories)
    }
  }
}

resource "aws_iam_role_policy_attachment" "policy-arns" {
  for_each   = toset(var.policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = each.key
}
data "aws_iam_policy_document" "combined-role-policy" {
  count                   = length(var.policy_jsons) > 0 ? 1 : 0
  source_policy_documents = var.policy_jsons
}


# Add actions missing from arn:aws:iam::aws:policy/ReadOnlyAccess
resource "aws_iam_policy" "additional-permissions" {
  count       = length(var.policy_jsons) > 0 ? 1 : 0
  name        = "${var.role_name}-policy"
  path        = "/"
  description = "A policy for additional permissions for ${var.role_name}"

  policy = data.aws_iam_policy_document.combined-role-policy[0].json
  tags   = var.tags
}

resource "aws_iam_role_policy_attachment" "additional-permissions" {
  count      = length(var.policy_jsons) > 0 ? 1 : 0
  role       = aws_iam_role.this.name
  policy_arn = aws_iam_policy.additional-permissions[0].arn
}