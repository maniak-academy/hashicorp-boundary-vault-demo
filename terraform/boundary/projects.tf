resource "boundary_scope" "project" {
  name                     = "Core Infrastructre"
  description              = "Backend infrastrcture project"
  scope_id                 = boundary_scope.org.id
  auto_create_admin_role   = true
  auto_create_default_role = true
}


