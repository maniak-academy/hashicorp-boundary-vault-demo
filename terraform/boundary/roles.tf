
resource "boundary_role" "global_anon_listing" {
  scope_id = "global"
  grant_strings = [
    "id=*;type=auth-method;actions=list,authenticate",
    "id=*;type=scope;actions=list,no-op",
    "id={{account.id}};actions=read,change-password"
  ]
  principal_ids = ["u_anon"]
}
resource "boundary_role" "org_anon_listing" {
  scope_id = boundary_scope.org.id
  grant_strings = [
    "id=*;type=auth-method;actions=list,authenticate",
    "type=scope;actions=list",
    "id={{account.id}};actions=read,change-password"
  ]
  principal_ids = ["u_anon"]
}

resource "boundary_role" "org_admin" {
    name          = "Org Admin Role"
  description   = "My Admin Role"
  scope_id       = "global"
  grant_scope_id = boundary_scope.org.id
  grant_strings = [
    "id=*;type=*;actions=*"
  ]
  principal_ids = [boundary_user.admin.id]
}
resource "boundary_role" "project_admin" {
  scope_id       = boundary_scope.org.id
  grant_scope_id = boundary_scope.project.id
  grant_strings = [
    "id=*;type=*;actions=*"
  ]
  principal_ids = [boundary_user.admin.id]
}