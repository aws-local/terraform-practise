# Creates a docker volume "jenkins_volume".
resource "docker_volume" "jenkins_volume" {
  name = "jenkins_data"
}

# Start a container
resource "docker_container" "jenkins_container" {
  name  = "jenkins"
  image = "jenkins:terraform"
  ports {
    internal = "8080"
    external = "8080"
  }

  volumes {
    volume_name    = docker_volume.jenkins_volume.name
    container_path = "/var/jenkins_home"
  }

  volumes {
    volume_name    = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
  }
}

