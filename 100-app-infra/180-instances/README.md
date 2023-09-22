## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_consul"></a> [consul](#provider\_consul) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_backend_asg"></a> [backend\_asg](#module\_backend\_asg) | git::https://github.com/terraform-aws-modules/terraform-aws-autoscaling.git | n/a |
| <a name="module_frontend_asg"></a> [frontend\_asg](#module\_frontend\_asg) | git::https://github.com/terraform-aws-modules/terraform-aws-autoscaling.git | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.describe_instances_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy_attachment.ec2_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy_attachment) | resource |
| [aws_iam_role.describe_instances_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_instance.fabio](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [consul_keys.fabio_private_ip](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/keys) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_secretsmanager_secret_version.consul_admin_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.security_group](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Region where to build infrastructure | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | Name of the team | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_fabio_public_ip"></a> [fabio\_public\_ip](#output\_fabio\_public\_ip) | The public IP of fabio host |
