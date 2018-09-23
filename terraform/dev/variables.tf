# Define your AWS region
variable "region" {
  default = "us-east-1"
}

# Project variables
variable "app_name" {}

variable "app_port" {}
variable "app_protocol" {}

variable "mytags" {
  type = "map"
}

# VPC variables
variable "vpc_id" {}

variable "vpc_subnets" {
  type = "list"
}

variable "peered_vpc" {}

# EC2 variables
variable "ec2_ami" {}

variable "ec2_instance_type" {}

variable "ec2_ssh_cidr" {
  type = "list"
}

# LB variables
variable "lb_port" {
  
}

variable "lb_protocol" {
  
}

# WAF variables
variable "waf_country" {}
