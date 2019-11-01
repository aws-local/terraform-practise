variable "mysql_root_password" {
  description = "The mySql root password"
  default     = "P4sSw0rd0!"
}

variable "ghost_db_username" {
  description = "DB user name"
  default     = "root"
}

variable "ghost_db_name" {
  description = "The Ghost DB name"
  default     = "ghost"
}

variable "mysql_network_alias" {
  description = "mysql DB network alias"
  default     = "db"
}

variable "ghost_network_alias" {
  description = "ghost network alias"
  default     = "ghost"
}

variable "ext_port" {
  description = "Public port for ghost"
  default     = "8080"
}

