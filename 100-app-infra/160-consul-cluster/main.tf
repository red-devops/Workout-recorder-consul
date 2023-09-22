resource "null_resource" "generate_consul_key" {
  provisioner "local-exec" {
    command = "/home/ubuntu/bin/consul keygen > keygen_file"
  }
}

resource "vault_generic_secret" "consul_keygen" {
  path       = "kv/consul/keygen"
  data_json  = <<EOT
    {
      "key": "${chomp(data.local_file.generated_key.content)}"
    }
  EOT
  depends_on = [null_resource.generate_consul_key]
}

resource "aws_instance" "consul_server" {
  count                = 3
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = "t3.micro"
  subnet_id            = data.terraform_remote_state.network.outputs.private_subnets[0]
  iam_instance_profile = aws_iam_instance_profile.consul_server_profile.name
  key_name             = "consul_${terraform.workspace}_key"

  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.consul_ec2_sg_id
  ]

  user_data = templatefile(
    "${path.root}/templates/user-data.sh",
    {
      env = "${terraform.workspace}"
    }
  )

  tags = merge(local.tags, {
    ostype = "linux"
  })
  depends_on = [vault_generic_secret.consul_keygen]
}

resource "time_sleep" "wait_5_minutes" {
  depends_on      = [aws_instance.consul_server]
  create_duration = "5m"
}