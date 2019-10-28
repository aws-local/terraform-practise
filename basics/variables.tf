variable "env" {
  description = "env: dev or prod"
}

variable "image_name" {
  type        = "map"
  description = "Image name to run container from."
  default = {
    dev  = "ghost:latest"
    prod = "ghost:alpine"
  }
}

variable "container_name" {
  type        = "map"
  description = "Name of the container"
  default = {
    dev  = "ghost_dev"
    prod = "ghost_prod"
  }
}

variable "int_port" {
  description = "Internal port"
  default     = "2368"
}

variable "ext_port" {
  type        = "map"
  description = "External port"
  default = {
    dev  = "8081"
    prod = "80"
  }
}
