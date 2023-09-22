## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | ~> 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |
| <a name="provider_consul"></a> [consul](#provider\_consul) | n/a |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | ~> 3.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_db"></a> [db](#module\_db) | git::https://github.com/terraform-aws-modules/terraform-aws-rds.git | n/a |
| <a name="module_db_setup_lambda"></a> [db\_setup\_lambda](#module\_db\_setup\_lambda) | git::https://github.com/terraform-aws-modules/terraform-aws-lambda.git | n/a |
| <a name="module_lambda_layer_local"></a> [lambda\_layer\_local](#module\_lambda\_layer\_local) | git::https://github.com/terraform-aws-modules/terraform-aws-lambda.git | n/a |

## Resources

| Name | Type |
|------|------|
| [consul_keys.database_endpoint](https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/keys) | resource |
| [local_file.render_db_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.render_python_script](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.invoke_lambda](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.db_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.db_workoutrecorder_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [vault_generic_secret.db_admin_secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [vault_generic_secret.db_workoutrecorder_secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |
| [aws_secretsmanager_secret_version.cicd_vault_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.consul_admin_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [terraform_remote_state.consul_instance](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.security_group](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.vault_instance](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Region where to build infrastructure | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | Name of the team | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_instance_endpoint"></a> [db\_instance\_endpoint](#output\_db\_instance\_endpoint) | The database connection endpoint |
