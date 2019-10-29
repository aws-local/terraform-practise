resource "docker_service" "ghost_service" {
  name = "ghost"

  task_spec {
    container_spec {
      image = "${docker_image.ghost_image.name}"

      env = {
        database__client              = "mysql"
        database__connection_host     = "${var.mysql_network_alias}"
        database__connection_user     = "${var.ghost_db_username}"
        database__connection_password = "${var.mysql_root_password}"
        database__connection_database = "${var.ghost_db_name}"
      }
    }
    networks = [
      "${docker_network.public_bridge_network.name}",
      "${docker_network.private_bridge_network.name}"
    ]
  }

  endpoint_spec {
    ports {
      target_port    = "2368"
      published_port = "${var.ext_port}"
    }
  }
}
resource "docker_service" "mysql_service" {
  name = "${var.mysql_network_alias}"
  task_spec {
    container_spec {
      image = "${docker_image.mysql_image.name}"

      env = {
        MYSQL_ROOT_PASSWORD = "${var.mysql_root_password}"
      }

      mounts {
          target = "/var/lib/mysql"
          source = "${docker_volume.mysql_data_volume.name}"
          type   = "volume"

        }
    }
    networks = ["${docker_network.private_bridge_network.name}"]
  }
}