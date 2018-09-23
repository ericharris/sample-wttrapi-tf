# Create ALB
resource "aws_lb" "lb" {
  name               = "${var.app_name}-${var.module_name}"
  internal           = "${var.lb_internal}"
  load_balancer_type = "application"
  security_groups    = ["${var.lb_sg}"]

  subnets = ["${var.vpc_subnets}"]

  enable_deletion_protection = false

  access_logs {
    bucket  = "${var.logging_bucket}"
    prefix  = "${var.app_name}-${var.module_name}"
    enabled = true
  }

  tags = "${merge(map("Name", "${var.app_name}-${var.module_name}"), var.mytags)}"
}

# Create ALB listener
resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn          = "${aws_lb.lb.arn}"
  port                       = "${var.lb_listener_port}"
  protocol                   = "${var.lb_listener_protocol}"

  default_action {
    target_group_arn = "${aws_lb_target_group.lb_target_group.arn}"
    type             = "forward"
  }
}

# Create ALB target group
resource "aws_lb_target_group" "lb_target_group" {
  name     = "${var.app_name}-${var.module_name}"
  port     = "${var.app_port}"
  protocol = "${var.app_protocol}"
  vpc_id   = "${var.vpc_id}"
}

# Attach EC2 instances to ALB target group
resource "aws_lb_target_group_attachment" "lb_tg_attachment" {
  target_group_arn = "${aws_lb_target_group.lb_target_group.arn}"
  target_id        = "${var.lb_ec2_ids}"
  port             = "${var.app_port}"
}
