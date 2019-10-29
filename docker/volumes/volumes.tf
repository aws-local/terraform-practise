# Creates a docker volume "shared_volume".
resource "docker_volume" "mysql_data_volume" {
  name = "mysql_data"
}

# Reference the volume with ${docker_volume.shared_volume.name}
