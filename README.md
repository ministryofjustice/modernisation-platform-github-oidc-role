# Modernisation Platform Github Web Identity Assumable Role Module

[![repo standards badge](https://img.shields.io/badge/dynamic/json?color=blue&style=for-the-badge&logo=github&label=MoJ%20Compliant&query=%24.result&url=https%3A%2F%2Foperations-engineering-reports.cloud-platform.service.justice.gov.uk%2Fapi%2Fv1%2Fcompliant_public_repositories%2Fmodernisation-platform-github-oidc-role)](https://operations-engineering-reports.cloud-platform.service.justice.gov.uk/public-github-repositories.html#modernisation-platform-github-oidc-role "Link to report")

## Usage

```hcl

module "github-webidentity-assumable-role" {

  source = "https://github.com/ministryofjustice/modernisation-platform-github-oidc-role"

  github_repositories         = ["ministryofjustice/modernisation-platform-environments:*","ministryofjustice/modernisation-platform:*"]
  role_name                   = "modernisation-platform-github-actions"
  policy_arns                 = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  policy_jsons                = [data.aws_iam_policy_document.first-policy.json, data.aws_iam_policy_document.second-policy.json]
  tags                        = local.tags

}

```

## Looking for issues?
If you're looking to raise an issue with this module, please create a new issue in the [Modernisation Platform repository](https://github.com/ministryofjustice/modernisation-platform/issues).

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.additional-permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.additional-permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.policy-arns](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.combined-role-policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_repositories"></a> [github\_repositories](#input\_github\_repositories) | The github repositories, for example ["ministryofjustice/modernisation-platform-environments:*"] | `list(string)` | n/a | yes |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | List of policy ARNs for the assumable role. Defaults to ["arn:aws:iam::aws:policy/ReadOnlyAccess"] | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/ReadOnlyAccess"<br>]</pre> | no |
| <a name="input_policy_jsons"></a> [policy\_jsons](#input\_policy\_jsons) | List of policy jsons for the assumable role. Defaults to [] | `list(string)` | `[]` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of role | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Common tags to be used by all resources | `map(string)` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_role"></a> [role](#output\_role) | IAM Role created for use by the OIDC provider |
| <a name="output_role_additional_permissions_policy"></a> [role\_additional\_permissions\_policy](#output\_role\_additional\_permissions\_policy) | Additional role policy for the role |
| <a name="output_role_trust_policy"></a> [role\_trust\_policy](#output\_role\_trust\_policy) | Assume role policy for the role |
<!-- END_TF_DOCS -->
