# Output the IP Address of container
output "ip_address" {
  value       = docker_container.container_id.ip_address
  description = "IP address of conatiner"
}

# Output the IP Address of container
output "container_name" {
  value       = docker_container.container_id.name
  description = "Name of conatiner"
}

