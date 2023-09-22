locals {
  name   = "SG-${terraform.workspace}"
  bucket = "red-devops-terraform-state"

  tags = {
    Name        = local.name
    Environment = terraform.workspace
    Create      = "terraform"
    Team        = var.team
  }

  allow_http = {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow http"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_https = {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow https"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_ssh = {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow ssh"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_mysql = {
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = null
    description      = "Allow mysql"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_8080 = {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow 8080"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_8200 = {
    from_port        = 8200
    to_port          = 8200
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow 8200"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_8201 = {
    from_port        = 8201
    to_port          = 8201
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow 8201"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_8300 = {
    from_port        = 8300
    to_port          = 8300
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow 8300"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_8301 = {
    from_port        = 8301
    to_port          = 8301
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow 8301"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_8301_udp = {
    from_port        = 8301
    to_port          = 8301
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow 8301"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_8500 = {
    from_port        = 8500
    to_port          = 8500
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow 8500"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_9998 = {
    from_port        = 9998
    to_port          = 9998
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow 9998"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_9999 = {
    from_port        = 9999
    to_port          = 9999
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow 9999"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_all = {
    from_port        = 0
    to_port          = 65535
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow all"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

  allow_all_udp = {
    from_port        = 0
    to_port          = 65535
    protocol         = "udp"
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Allow all udp"
    ipv6_cidr_blocks = null
    prefix_list_ids  = null
    security_groups  = null
    self             = false
  }

}