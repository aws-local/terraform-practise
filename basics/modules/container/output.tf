output "container_name" {
  value = "${docker_container.container_id.name}"
}

output "ip" {
  value = "${docker_container.container_id.ip_address}"
}
