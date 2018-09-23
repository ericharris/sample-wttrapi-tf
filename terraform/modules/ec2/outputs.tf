output "ec2_id" {
  value = "${aws_instance.ec2.id}"
}

output "ec2_dns" {
  value = "${aws_instance.ec2.public_dns}"
}

output "ec2_ip" {
  value = "${aws_instance.ec2.public_ip}"
}
