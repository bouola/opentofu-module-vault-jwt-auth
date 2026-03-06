# Configures the JWT/OIDC authentication backend to allow external identity providers (like GitLab or Google) to authenticate users.
resource "vault_jwt_auth_backend" "jwt_backend" {
  path               = var.vault_jwt_auth_backend_settings.path
  type               = var.vault_jwt_auth_backend_settings.type
  oidc_discovery_url = var.vault_jwt_auth_backend_settings.oidc_discovery_url
  oidc_client_id     = var.vault_jwt_auth_backend_settings.oidc_client_id
  oidc_client_secret = var.vault_jwt_auth_backend_oidc_client_secret
  default_role       = var.vault_jwt_auth_backend_settings.default_role
  bound_issuer       = lookup(var.vault_jwt_auth_backend_settings, "bound_issuer", null)
}

locals {
  roles_from_list = { for role in var.vault_jwt_auth_backend_roles : role.role_name => role }
  role_json_files = var.vault_jwt_auth_backend_roles_path != null ? fileset(var.vault_jwt_auth_backend_roles_path, "*.json") : []
  decoded_json_roles = [for file in local.role_json_files : jsondecode(file("${var.vault_jwt_auth_backend_roles_path}/${file}"))]

  roles_from_json_path = { for role in local.decoded_json_roles : role.role_name => role }
  jwt_backend_roles = merge(
    local.roles_from_list,
    local.roles_from_json_path
  )
}

# Defines specific roles within the JWT backend to map claims from the identity provider to Vault policies and tokens.
resource "vault_jwt_auth_backend_role" "jwt_backend_roles" {
  for_each = local.jwt_backend_roles

  backend   = vault_jwt_auth_backend.jwt_backend.path
  role_name = endswith(each.value.role_name, "-role") ? each.value.role_name : "${each.value.role_name}-role"
  role_type = each.value.role_type
  bound_audiences = each.value.bound_audiences

  allowed_redirect_uris = lookup(each.value, "allowed_redirect_uris", null)
  oidc_scopes           = lookup(each.value, "oidc_scopes", null)

  user_claim   = each.value.user_claim
  groups_claim = lookup(each.value, "group_claim", null)
  bound_claims = lookup(each.value, "bound_claims", null)

  token_policies = lookup(each.value, "token_policies", [])
  token_ttl      = lookup(each.value, "token_ttl", 3600)
  token_max_ttl  = lookup(each.value, "token_max_ttl", 14400)

  verbose_oidc_logging = lookup(each.value, "verbose_oidc_logging", false)
}
