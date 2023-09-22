resource "aws_dynamodb_table" "vault_storage_table" {
  name           = "${local.name}-storage-table"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "Path"
  range_key      = "Key"

  attribute {
    name = "Path"
    type = "S"
  }

  attribute {
    name = "Key"
    type = "S"
  }

  tags = local.tags
}

resource "aws_instance" "vault_server" {
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"
  subnet_id            = data.terraform_remote_state.network.outputs.private_subnets[0]
  iam_instance_profile = aws_iam_instance_profile.vault_server_profile.name
  key_name             = "vault_${terraform.workspace}_key"

  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.vault_ec2_sg_id
  ]

  user_data = templatefile(
    "${path.root}/templates/user-data.sh",
    {
      env = "${terraform.workspace}"
    }
  )

  lifecycle {
    prevent_destroy = false
  }

  tags = merge(local.tags, {
    ostype = "linux"
  })
}

resource "time_sleep" "wait_5_minutes" {
  depends_on      = [aws_instance.vault_server]
  create_duration = "5m"
}
