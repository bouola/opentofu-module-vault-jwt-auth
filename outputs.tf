output "backend_path" {
  value       = vault_jwt_auth_backend.jwt_backend.path
  description = "The path where the JWT/OIDC authentication backend is mounted."
}

output "backend_accessor" {
  value       = vault_jwt_auth_backend.jwt_backend.accessor
  description = "The mount accessor for the JWT/OIDC authentication backend, used for mapping groups and entities."
}

output "backend_roles" {
  value = { for role in vault_jwt_auth_backend_role.jwt_backend_roles : role.role_name => role }
}

output "debug" {
  value = local.decoded_json_roles
}
