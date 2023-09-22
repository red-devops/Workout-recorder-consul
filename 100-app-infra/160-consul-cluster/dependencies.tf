terraform {
  required_version = "~> 1.2"
  required_providers {
    aws = {
      version = "~> 5.0"
    }
  }
  backend "s3" {
    key = "consul-instance.tfstate"
  }
}

provider "vault" {
  address = "http://${data.terraform_remote_state.vault_instance.outputs.vault_private_ip}:8200"
  token   = jsondecode(data.aws_secretsmanager_secret_version.cicd_vault_token.secret_string)["cicd-token"]
}
