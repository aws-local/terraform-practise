resource "docker_image" "image_id" {
  name = var.image_name[var.env]
}

resource "docker_container" "container_id" {
  name  = var.container_name[var.env]
  image = docker_image.image_id.latest
  ports {
    internal = var.int_port
    external = var.ext_port[var.env]
  }
}

resource "null_resource" "null_id" {
  provisioner "local-exec" {
    command = "echo ${docker_container.container_id.name}:${docker_container.container_id.ip_address} >> container.txt"
  }
}

