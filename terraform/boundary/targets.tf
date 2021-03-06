# resource "boundary_target" "backend_servers_ssh" {
#   type                     = "tcp"
#   name                     = "backend_servers_ssh"
#   description              = "Backend SSH target"
#   scope_id                 = boundary_scope.project.id
#   session_connection_limit = -1
#   default_port             = 22
#   host_source_ids = [
#     boundary_host_set.backend_servers.id
#   ]
# }

# resource "boundary_host_catalog" "backend_servers" {
#   name        = "backend_servers"
#   description = "Web servers for backend team"
#   type        = "static"
#   scope_id    = boundary_scope.project.id
# }

# resource "boundary_host" "backend_servers" {
#   for_each        = var.target_ips
#   type            = "static"
#   name            = "backend_server_${each.value}"
#   description     = "Backend server #${each.value}"
#   address         = each.key
#   host_catalog_id = boundary_host_catalog.backend_servers.id
# }

# resource "boundary_host_set" "backend_servers" {
#   type            = "static"
#   name            = "backend_servers"
#   description     = "Host set for backend servers"
#   host_catalog_id = boundary_host_catalog.backend_servers.id
#   host_ids        = [for host in boundary_host.backend_servers : host.id]
# }

