# terraform.tfvars will setup the variables passed to the modules. This can be unique for each environment.

# existing VPC info
vpc_id = ""
vpc_subnets = [""] // enter the VPC subnets you would like ALBs to use here
peered_vpc = "" // enter your peered VPC-ID here

# application settings
app_name = "dev-wttr"
app_port = "8002"
app_protocol = "HTTP"

# ec2 settings
ec2_ami = "ami-0ff8a91507f77f867" // enter your prefered AMI ID here
ec2_instance_type = "t2.nano"
# ec2_instance_count = "1" // future use - use count function to create multiple instances
ec2_ssh_cidr = [""] // any CIDR ranges you would like to SSH from

# LB settings
lb_port = "80"
lb_protocol = "HTTP"

# WAF for public LB
waf_country = "US"

# Tags to set on resources
mytags = {
  Project     = "wttr.in API stack"
  Owner       = "Eric Harris"
  Environment = "Development"
}
