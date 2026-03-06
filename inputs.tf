variable "vault_jwt_auth_backend_settings" {
  type = object({
    path               = string
    type               = string
    description        = string
    oidc_discovery_url = string
    oidc_client_id     = string
    default_role       = string
    bound_issuer       = optional(string)
  })
  description = "General settings for the Vault JWT/OIDC authentication backend, including discovery URL and client credentials."
}

variable "vault_jwt_auth_backend_oidc_client_secret" {
  type        = string
  description = "The OIDC client secret used for authentication with the identity provider. Kept separate for security."
  sensitive   = true
  default     = null
}

variable "vault_jwt_auth_backend_roles" {
  type = list(object({
    role_name             = string
    role_type             = string
    bound_audiences       = list(string)
    allowed_redirect_uris = optional(list(string))
    oidc_scopes           = optional(list(string))
    user_claim            = string
    group_claim           = optional(string)
    bound_claims          = optional(map(any))
    verbose_oidc_logging  = optional(bool, false)
    token_policies        = optional(list(string), [])
    token_ttl             = optional(number, 3600)
    token_max_ttl         = optional(number, 14400)
  }))
  description = "List of roles to configure for the JWT/OIDC backend, defining how users and groups are mapped to Vault policies."
  default     = []
}

variable "vault_jwt_auth_backend_roles_path" {
  type        = string
  description = "Path to a directory containing JSON files defining additional JWT roles."
  default     = null
}
