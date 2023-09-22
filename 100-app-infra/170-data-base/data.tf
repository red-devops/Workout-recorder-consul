
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "env:/${terraform.workspace}/network.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "security_group" {
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "env:/${terraform.workspace}/security-group.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "vault_instance" {
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "env:/${terraform.workspace}/vault-instance.tfstate"
    region = var.region
  }
}

data "terraform_remote_state" "consul_instance" {
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "env:/${terraform.workspace}/consul-instance.tfstate"
    region = var.region
  }
}

data "aws_secretsmanager_secret_version" "cicd_vault_token" {
  secret_id = "cicd-vault-${terraform.workspace}-token"
}

data "aws_secretsmanager_secret_version" "consul_admin_token" {
  secret_id = "Consul-Global-Managemen-Token-${terraform.workspace}"
}