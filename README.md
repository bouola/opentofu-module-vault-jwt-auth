# opentofu-module-vault-jwt-auth
Vault configure jwt authentication with opentofu

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | >= 5.7.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_vault"></a> [vault](#provider\_vault) | >= 5.7.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [vault_jwt_auth_backend.jwt_backend](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend) | resource |
| [vault_jwt_auth_backend_role.jwt_backend_roles](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/jwt_auth_backend_role) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vault_jwt_auth_backend_oidc_client_secret"></a> [vault\_jwt\_auth\_backend\_oidc\_client\_secret](#input\_vault\_jwt\_auth\_backend\_oidc\_client\_secret) | The OIDC client secret used for authentication with the identity provider. Kept separate for security. | `string` | `null` | no |
| <a name="input_vault_jwt_auth_backend_roles"></a> [vault\_jwt\_auth\_backend\_roles](#input\_vault\_jwt\_auth\_backend\_roles) | List of roles to configure for the JWT/OIDC backend, defining how users and groups are mapped to Vault policies. | <pre>list(object({<br/>    role_name             = string<br/>    role_type             = string<br/>    bound_audiences       = list(string)<br/>    allowed_redirect_uris = optional(list(string))<br/>    oidc_scopes           = optional(list(string))<br/>    user_claim            = string<br/>    group_claim           = optional(string)<br/>    bound_claims          = optional(map(any))<br/>    verbose_oidc_logging  = optional(bool, false)<br/>    token_policies        = optional(list(string), [])<br/>    token_ttl             = optional(number, 3600)<br/>    token_max_ttl         = optional(number, 14400)<br/>  }))</pre> | `[]` | no |
| <a name="input_vault_jwt_auth_backend_roles_path"></a> [vault\_jwt\_auth\_backend\_roles\_path](#input\_vault\_jwt\_auth\_backend\_roles\_path) | Path to a directory containing JSON files defining additional JWT roles. | `string` | `null` | no |
| <a name="input_vault_jwt_auth_backend_settings"></a> [vault\_jwt\_auth\_backend\_settings](#input\_vault\_jwt\_auth\_backend\_settings) | General settings for the Vault JWT/OIDC authentication backend, including discovery URL and client credentials. | <pre>object({<br/>    path               = string<br/>    type               = string<br/>    description        = string<br/>    oidc_discovery_url = string<br/>    oidc_client_id     = string<br/>    default_role       = string<br/>    bound_issuer       = optional(string)<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_accessor"></a> [backend\_accessor](#output\_backend\_accessor) | The mount accessor for the JWT/OIDC authentication backend, used for mapping groups and entities. |
| <a name="output_backend_path"></a> [backend\_path](#output\_backend\_path) | The path where the JWT/OIDC authentication backend is mounted. |
| <a name="output_backend_roles"></a> [backend\_roles](#output\_backend\_roles) | n/a |
| <a name="output_debug"></a> [debug](#output\_debug) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
