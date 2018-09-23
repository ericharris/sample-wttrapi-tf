# Use the aws provider to provision in AWS
provider "aws" {
  region = "${var.region}"
}

# Gather data about environment
data "aws_vpc" "vpc" {
  id = "${var.vpc_id}"
}

data "aws_vpc" "peered-vpc" {
  id = "${var.peered_vpc}"
}

# Create S3 logging bucket
module "logging-bucket" {
  source      = "../modules/s3/"
  module_name = "logging-bucket"
  app_name    = "${var.app_name}"
  mytags      = "${var.mytags}"
}

#####################
### Private Stack ###
#####################

# Create ec2 instance security group
module "private-ec2-sg" {
  source      = "../modules/sg/"
  module_name = "private-ec2-sg"
  app_name    = "${var.app_name}"
  mytags      = "${var.mytags}"
}

# Create the ec2 instance
module "private-ec2" {
  source            = "../modules/ec2/"
  module_name       = "private-ec2"
  ec2_ami           = "${var.ec2_ami}"
  app_name          = "${var.app_name}"
  ec2_instance_type = "${var.ec2_instance_type}"
  vpc_sg            = "${module.private-ec2-sg.sg_id}"
  mytags            = "${var.mytags}"
}

# Create security group for ALB
module "private-lb-sg" {
  source      = "../modules/sg/"
  module_name = "private-lb-sg"
  app_name    = "${var.app_name}"
  mytags      = "${var.mytags}"
}

# Create ALB for ec2 instance
module "private-lb" {
  source               = "../modules/lb/"
  module_name          = "private-lb"
  app_name             = "${var.app_name}"
  app_port             = "${var.app_port}"
  app_protocol         = "${var.app_protocol}"
  vpc_id               = "${var.vpc_id}"
  vpc_subnets          = "${var.vpc_subnets}"
  lb_ec2_ids           = "${module.private-ec2.ec2_id}"
  lb_internal          = "true"
  lb_sg                = "${module.private-lb-sg.sg_id}"
  lb_listener_port     = "${var.lb_port}"
  lb_listener_protocol = "${var.lb_protocol}"
  logging_bucket       = "${module.logging-bucket.s3_id}"
  mytags               = "${var.mytags}"
}

####################
### Public Stack ###
####################
# Create ec2 instance security group
module "public-ec2-sg" {
  source      = "../modules/sg/"
  module_name = "public-ec2-sg"
  app_name    = "${var.app_name}"
  mytags      = "${var.mytags}"
}

# Create the ec2 instance
module "public-ec2" {
  source            = "../modules/ec2/"
  module_name       = "public-ec2"
  ec2_ami           = "${var.ec2_ami}"
  app_name          = "${var.app_name}"
  ec2_instance_type = "${var.ec2_instance_type}"
  vpc_sg            = "${module.public-ec2-sg.sg_id}"
  mytags            = "${var.mytags}"
}

# Create security group for ALB
module "public-lb-sg" {
  source      = "../modules/sg/"
  module_name = "public-lb-sg"
  app_name    = "${var.app_name}"
  mytags      = "${var.mytags}"
}

# Create ALB for ec2 instance
module "public-lb" {
  source               = "../modules/lb/"
  module_name          = "public-lb"
  vpc_id               = "${var.vpc_id}"
  vpc_subnets          = "${var.vpc_subnets}"
  app_name             = "${var.app_name}"
  app_port             = "${var.app_port}"
  app_protocol         = "${var.app_protocol}"
  lb_ec2_ids           = "${module.public-ec2.ec2_id}"
  lb_internal          = "false"
  lb_listener_port     = "${var.lb_port}"
  lb_listener_protocol = "${var.lb_protocol}"
  lb_sg                = "${module.public-lb-sg.sg_id}"
  logging_bucket       = "${module.logging-bucket.s3_id}"
  mytags               = "${var.mytags}"
}

# Create WAF for public ALB
module "public-waf" {
  source      = "../modules/waf"
  app_name    = "${var.app_name}"
  module_name = "public-lb"
  waf_lb      = "${module.public-lb.lb_arn}"
  waf_country = "${var.waf_country}"
  waf_name    = "AllowUSOnly"
  waf_metric  = "AllowUSOnly"
  mytags      = "${var.mytags}"
}
