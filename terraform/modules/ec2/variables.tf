variable "app_name" {}
variable "module_name" {}
variable "ec2_ami" {}
variable "ec2_instance_type" {}

variable "vpc_sg" {}

variable "mytags" {
  type = "map"
}
