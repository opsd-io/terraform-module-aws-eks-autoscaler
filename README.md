<a href="https://www.opsd.io" target="_blank"><img alt="OPSd" src=".github/img/OPSD_logo.svg" width="180px"></a>

Meet **OPSd**. The unique and effortless way of managing cloud infrastructure.

# terraform-module-aws-eks-autoscaler

## Introduction

What does the module provide?

## Usage

```hcl
module "autoscaler" {
  source         = "github.com/opsd-io/terraform-module-eks-autoscaler"
  cluster_region = module.kubernetes.region
  cluster_name   = module.kubernetes.name
  openid_arn     = module.kubernetes.openid_arn
  openid_sub     = module.kubernetes.openid_sub
}
```

**IMPORTANT**: Make sure not to pin to master because there may be breaking changes between releases.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.5.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [helm_release.main](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | Specify the exact chart version to install. | `string` | `null` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster. | `string` | n/a | yes |
| <a name="input_cluster_region"></a> [cluster\_region](#input\_cluster\_region) | The AWS region of the cluster. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the release into. | `string` | `"kube-system"` | no |
| <a name="input_openid_arn"></a> [openid\_arn](#input\_openid\_arn) | The ARN assigned by AWS for IAM OpenID Connect of the cluster. | `string` | `null` | no |
| <a name="input_openid_sub"></a> [openid\_sub](#input\_openid\_sub) | The URL of the identity provider. Corresponds to the iss claim. | `string` | `null` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | The release name. | `string` | `"cluster-autoscaler"` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | The name of IAM Roles for Service Account to create. Defaults to $cluster\_name-autoscaler. | `string` | `null` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | The name of the service account to create. | `string` | `"cluster-autoscaler"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_role_arn"></a> [cluster\_role\_arn](#output\_cluster\_role\_arn) | The ARN of the IAM role that provides permissions for cluster-autoscaler. |
| <a name="output_cluster_role_name"></a> [cluster\_role\_name](#output\_cluster\_role\_name) | The name of the IAM role that provides permissions for cluster-autoscaler. |
<!-- END_TF_DOCS -->

## Examples of usage

Do you want to see how the module works? See all the [usage examples](examples).

## Related modules

The list of related modules (if present).

## Contributing

If you are interested in contributing to the project, see see our [guide](https://github.com/opsd-io/contribution).

## Support

If you have a problem with the module or want to propose a new feature, you can report it via the project's (Github) issue tracker.

If you want to discuss something in person, you can join our community on [Slack](https://join.slack.com/t/opsd-community/signup).

## License

[Apache License 2.0](LICENSE)
