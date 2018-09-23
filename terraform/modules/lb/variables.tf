variable "vpc_id" {}

variable "vpc_subnets" {
  type = "list"
}

variable "app_name" {}
variable "app_port" {
  
}
variable "app_protocol" {
  
}

variable "module_name" {}
variable "lb_ec2_ids" {}

variable "lb_internal" {}
variable "lb_sg" {}
variable "lb_listener_port" {}
variable "lb_listener_protocol" {}

variable "logging_bucket" {}

variable "mytags" {
  type = "map"
}
