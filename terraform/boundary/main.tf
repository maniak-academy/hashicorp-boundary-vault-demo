terraform {
  required_providers {
    boundary = {
      source  = "hashicorp/boundary"
      version = "1.0.5"
    }
  }
}

provider "boundary" {
  addr             = var.url
  recovery_kms_hcl = <<EOT
kms "awskms" {
	purpose    = "recovery"
	key_id     = "global_root"
  kms_key_id = "${var.kms_recovery_key_id}"
}
EOT
}

#first login account
resource "boundary_scope" "org" {
  scope_id    = "global"
  name        = "Maniak Academy"
  description = "Maniak Academy scope"
  auto_create_admin_role   = true
  auto_create_default_role = false
}


#Create an auth method
resource "boundary_auth_method" "password" {
  name        = "Password Auth"
  description = "Password auth method"
  type        = "password"
  scope_id    = boundary_scope.org.id
}

#Create a login
resource "boundary_account" "admin" {
  name = "admin"
  login_name     = "admin"
  description    = "User account for my user"
  type           = "password"
  password       = "foofoofoo"
  auth_method_id = boundary_auth_method.password.id
}

#create a user
resource "boundary_user" "admin" {
  name        = "admin"
  description = "Super User"
  account_ids = [boundary_account.admin.id]
  scope_id    = boundary_scope.org.id
}
