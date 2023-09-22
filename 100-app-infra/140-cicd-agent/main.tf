resource "aws_instance" "cicd_agent" {
  ami                  = var.ami_mapping[terraform.workspace]
  instance_type        = "t3.small"
  subnet_id            = data.terraform_remote_state.network.outputs.private_subnets[0]
  iam_instance_profile = aws_iam_instance_profile.cicd_profile.name
  vpc_security_group_ids = [
    data.terraform_remote_state.security_group.outputs.cicd_ec2_sg_id
  ]

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 20
    delete_on_termination = true
  }

  lifecycle {
    prevent_destroy = false
  }

  tags = merge(local.tags, {
    ostype = "linux"
  })
}

resource "aws_iam_instance_profile" "cicd_profile" {
  name = "${local.name}-profile"
  role = "${local.name}-role"
}
