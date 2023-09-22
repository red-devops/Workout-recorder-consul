## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_region"></a> [region](#input\_region) | Region where to build infrastructure | `string` | n/a | yes |
| <a name="input_team"></a> [team](#input\_team) | Name of the team | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnet_group"></a> [database\_subnet\_group](#output\_database\_subnet\_group) | The ID of database subnet |
| <a name="output_database_subnets_cidr_blocks"></a> [database\_subnets\_cidr\_blocks](#output\_database\_subnets\_cidr\_blocks) | The cidr\_block of database subnet |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | The ID of private subnet |
| <a name="output_private_subnets_cidr_blocks"></a> [private\_subnets\_cidr\_blocks](#output\_private\_subnets\_cidr\_blocks) | The cidr\_block of private subnet |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | The ID of public subnet |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
