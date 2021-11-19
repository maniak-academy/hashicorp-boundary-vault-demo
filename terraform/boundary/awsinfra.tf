
resource "boundary_host_catalog" "aws_infrastructure" {
  name        = "AWS Infrastructure"
  description = "AWS Infrastructure Access"
  type        = "static"
  scope_id    = boundary_scope.project.id
}

resource "boundary_host" "linuxserver1" {
  name            = "linuxserver1"
  description     = "My EC2 linux server"
  address         = "10.0.100.26"
  type        = "static"
  host_catalog_id = boundary_host_catalog.aws_infrastructure.id
}

resource "boundary_host" "linuxserver2" {
  name            = "linuxserver2"
  description     = "My EC2 linux server"
  address         = "10.0.100.13"
  type        = "static"
  host_catalog_id = boundary_host_catalog.aws_infrastructure.id
}

resource "boundary_host_set" "aws_linux" {
  type            = "static"
  name            = "aws_linux"
  description     = "AWS Infrastructure Linux"
  host_catalog_id = boundary_host_catalog.aws_infrastructure.id
  host_ids = [
    boundary_host.linuxserver1.id,
    boundary_host.linuxserver2.id
  ]
}

resource "boundary_credential_store_vault" "vaultstore1" {
  name        = "vaultstore1"
  description = "My first Vault credential store!"
  address     = "http://3.93.198.228:8200"      # change to Vault address
  token       = "s.1eLpdPEW8320WVx6gYUrdHJY" # change to valid Vault token
  scope_id    = boundary_scope.project.id
}

resource "boundary_credential_library_vault" "vault-awslinux" {
  name                = "vault-awslinux"
  description         = "My Aws linux Vault credential library!"
  credential_store_id = boundary_credential_store_vault.vaultstore1.id
  path                = "infra/data/aws" # change to Vault backend path
  http_method         = "GET"
}


resource "boundary_target" "linux" {
  name         = "linux"
  description  = "linux target"
  type         = "tcp"
  default_port = "22"
  scope_id     = boundary_scope.project.id
  host_source_ids = [
    boundary_host_set.aws_linux.id
  ]
  application_credential_source_ids = [
    boundary_credential_library_vault.vault-awslinux.id
  ]
}