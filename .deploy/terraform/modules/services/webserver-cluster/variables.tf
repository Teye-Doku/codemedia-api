variable "region" {
  description = "this is region where the cluster whom be hosted"
  type        = string
}

variable "server_port" {
  description = "this is the port for the server"
  type        = number
}

variable "instance_type" {
  description = "instance to be used"
  type        = string
}