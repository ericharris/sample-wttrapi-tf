output "s3_logging_bucket" {
  value = "${module.logging-bucket.s3_id}"
}

output "private_ec2_id" {
  value = "${module.private-ec2.ec2_id}"
}

output "private_ec2_dns" {
  value = "${module.private-ec2.ec2_dns}"
}

output "private_ec2_ip" {
  value = "${module.private-ec2.ec2_ip}"
}

output "private_lb_dns" {
  value = "${module.private-lb.lb_dns}"
}

output "public_ec2_id" {
  value = "${module.public-ec2.ec2_id}"
}

output "public_ec2_dns" {
  value = "${module.public-ec2.ec2_dns}"
}

output "public_ec2_ip" {
  value = "${module.public-ec2.ec2_ip}"
}

output "public_lb_dns" {
  value = "${module.public-lb.lb_dns}"
}
