resource "consul_keys" "fabio_private_ip" {
  key {
    path  = "config/workoutrecorder/fabio-private_ip"
    value = aws_instance.fabio.private_ip
  }
}

resource "consul_acl_token" "backend" {
  description = "Token for backend"
  policies    = ["${consul_acl_policy.backend.name}"]
}

resource "consul_acl_token" "frontend" {
  description = "Token for frontend"
  policies    = ["${consul_acl_policy.frontend.name}"]
}

resource "consul_acl_token" "fabio" {
  description = "Token for fabio"
  policies    = ["${consul_acl_policy.fabio.name}"]
}

resource "consul_acl_token_policy_attachment" "attachment_ui" {
  token_id = "00000000-0000-0000-0000-000000000002"
  policy   = consul_acl_policy.ui.name
}

resource "consul_acl_token_policy_attachment" "attachment_key_deny" {
  token_id = "00000000-0000-0000-0000-000000000002"
  policy   = consul_acl_policy.key_deny.name
}

resource "consul_acl_policy" "backend" {
  name        = "backend"
  description = "Policy for backend"
  rules       = <<-RULE
    service "backend" {
      policy = "write"
    }

    service_prefix "" {
    policy = "read"
    }

    node_prefix "backend" {
    policy = "write"
    }

    node_prefix "" {
    policy = "read"
    }

    session "backend" {
    policy = "write"
    }

    agent "backend" {
    policy = "write"
    }
    RULE
}

resource "consul_acl_policy" "frontend" {
  name        = "frontend"
  description = "Policy for frontend"
  rules       = <<-RULE
    service "frontend" {
      policy = "write"
    }

    service_prefix "" {
      policy = "read"
    }

    node_prefix "frontend" {
      policy = "write"
    }

    node_prefix "" {
      policy = "read"
    }

    session "frontend" {
      policy = "write"
    }

    agent "frontend" {
      policy = "write"
    }
    RULE
}

resource "consul_acl_policy" "fabio" {
  name        = "fabio"
  description = "Policy for fabio"
  rules       = <<-RULE
    service "fabio" {
      policy = "write"
    }

    service_prefix "" {
      policy = "read"
    }

    node_prefix "fabio" {
      policy = "write"
    }

    node_prefix "" {
      policy = "read"
    }

    session "fabio" {
      policy = "write"
    }

    agent "fabio" {
      policy = "write"
    }

    agent_prefix "" {
      policy = "read"
    }
    RULE
}

resource "consul_acl_policy" "ui" {
  name        = "ui"
  description = "Policy for user interface"
  rules       = <<-RULE
    service_prefix "" {
      policy = "read"
    }

    node_prefix "" {
      policy = "read"
    }

    key_prefix "" {
      policy = "read"
    }
    RULE
}

resource "consul_acl_policy" "key_deny" {
  name        = "key-deny"
  description = "Policy for key deny"
  rules       = <<-RULE
    key_prefix "" {
      policy = "deny"
    }
    RULE
}
