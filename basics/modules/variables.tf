variable "image_name" {
  description = " Name of the image to run container of"
  default     = "ghost:latest"
}
variable "container_name" {
  description = "Name to be given to container"
  default     = "blog"
}
variable "ext_port" {
  description = "External port to be exposed"
  default     = "80"
}
variable "int_port" {
  description = "internal port of container on which service runs"
  default     = "2368"
}
