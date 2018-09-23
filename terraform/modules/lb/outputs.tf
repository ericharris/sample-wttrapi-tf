output "lb_id" {
  value = "${aws_lb.lb.id}"
}

output "lb_dns" {
  value = "${aws_lb.lb.dns_name}"
}

output "lb_arn" {
  value = "${aws_lb.lb.arn}"
}
