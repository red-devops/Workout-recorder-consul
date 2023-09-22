terraform {
  required_version = "~> 1.2"
  required_providers {
    aws = {
      version = "~> 5.0"
    }
  }
  backend "s3" {
    key = "instances.tfstate"
  }
}

provider "aws" {
  region = var.region
}

provider "consul" {
  address    = "http://${data.terraform_remote_state.consul_instance.outputs.consul_private_ip}:8500"
  token      = jsondecode(data.aws_secretsmanager_secret_version.consul_admin_token.secret_string)["acl-bootsrap-token"]
  datacenter = "${terraform.workspace}-${var.region}"
}
