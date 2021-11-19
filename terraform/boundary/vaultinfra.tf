
resource "boundary_host_catalog" "vault_infrastructure" {
  name        = "vault Infrastructure"
  description = "vault Infrastructure Access"
  type        = "static"
  scope_id    = boundary_scope.project.id
}

resource "boundary_host" "vaultserver" {
  name            = "vaultserver"
  description     = "My vault server"
  address         = "10.0.100.7"
  type        = "static"
  host_catalog_id = boundary_host_catalog.vault_infrastructure.id
}


resource "boundary_host_set" "vaultserver" {
  type            = "static"
  name            = "vaultserver"
  description     = "Vault Infrastructure Linux"
  host_catalog_id = boundary_host_catalog.vault_infrastructure.id
  host_ids = [
    boundary_host.vaultserver.id
  ]
}



resource "boundary_target" "vaultserver" {
  name         = "vaultserver"
  description  = "vaultserver target"
  type         = "tcp"
  default_port = "22"
  scope_id     = boundary_scope.project.id
  host_source_ids = [
    boundary_host_set.vaultserver.id
  ]
}