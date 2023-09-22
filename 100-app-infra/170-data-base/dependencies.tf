terraform {
  required_version = "~> 1.2"
  required_providers {
    aws = {
      version = "~> 5.0"
    }
    vault = {
      version = "~> 3.1"
    }
  }
  backend "s3" {
    key = "data-base.tfstate"
  }
}

provider "aws" {
  region = var.region
}

provider "vault" {
  address = "http://${data.terraform_remote_state.vault_instance.outputs.vault_private_ip}:8200"
  token   = jsondecode(data.aws_secretsmanager_secret_version.cicd_vault_token.secret_string)["cicd-token"]
}

provider "consul" {
  address    = "http://${data.terraform_remote_state.consul_instance.outputs.consul_private_ip}:8500"
  token      = jsondecode(data.aws_secretsmanager_secret_version.consul_admin_token.secret_string)["acl-bootsrap-token"]
  datacenter = "${terraform.workspace}-${var.region}"
}
