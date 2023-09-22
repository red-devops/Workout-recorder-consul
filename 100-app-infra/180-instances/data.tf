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

data "terraform_remote_state" "consul_instance" {
  backend = "s3"
  config = {
    bucket = local.bucket
    key    = "env:/${terraform.workspace}/consul-instance.tfstate"
    region = var.region
  }
}

data "aws_secretsmanager_secret_version" "consul_admin_token" {
  secret_id = "Consul-Global-Managemen-Token-${terraform.workspace}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
