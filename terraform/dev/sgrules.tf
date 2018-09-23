# SG rules for private stack
resource "aws_security_group_rule" "private-lb-to-private-ec2" {
  type                     = "ingress"
  from_port                = "${var.app_port}"
  to_port                  = "${var.app_port}"
  protocol                 = "TCP"
  source_security_group_id = "${module.private-lb-sg.sg_id}"
  security_group_id        = "${module.private-ec2-sg.sg_id}"
}

resource "aws_security_group_rule" "private-ec2-to-private-lb" {
  type                     = "egress"
  from_port                = "${var.app_port}"
  to_port                  = "${var.app_port}"
  protocol                 = "TCP"
  source_security_group_id = "${module.private-ec2-sg.sg_id}"
  security_group_id        = "${module.private-lb-sg.sg_id}"
}

resource "aws_security_group_rule" "private-ec2-egress-80" {
  type              = "egress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.private-ec2-sg.sg_id}"
}

resource "aws_security_group_rule" "private-ec2-egress-443" {
  type              = "egress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.private-ec2-sg.sg_id}"
}

resource "aws_security_group_rule" "vpc-to-private-lb" {
  type              = "ingress"
  from_port         = "${var.lb_port}"
  to_port           = "${var.lb_port}"
  protocol          = "TCP"
  cidr_blocks       = ["${data.aws_vpc.vpc.cidr_block}"]
  security_group_id = "${module.private-lb-sg.sg_id}"
}

resource "aws_security_group_rule" "peered-vpc-to-private-lb" {
  type              = "ingress"
  from_port         = "${var.lb_port}"
  to_port           = "${var.lb_port}"
  protocol          = "TCP"
  cidr_blocks       = ["${data.aws_vpc.peered-vpc.cidr_block}"]
  security_group_id = "${module.private-lb-sg.sg_id}"
}

resource "aws_security_group_rule" "private-lb-to-peered-vpc" {
  type              = "egress"
  from_port         = "${var.lb_port}"
  to_port           = "${var.lb_port}"
  protocol          = "TCP"
  cidr_blocks       = ["${data.aws_vpc.peered-vpc.cidr_block}"]
  security_group_id = "${module.private-lb-sg.sg_id}"
}

resource "aws_security_group_rule" "ssh-to-private-ec2" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "TCP"
  cidr_blocks       = ["${var.ec2_ssh_cidr}"]
  security_group_id = "${module.private-ec2-sg.sg_id}"
}

# SG rules for private stack
resource "aws_security_group_rule" "public-lb-to-public-ec2" {
  type                     = "ingress"
  from_port                = "${var.app_port}"
  to_port                  = "${var.app_port}"
  protocol                 = "TCP"
  source_security_group_id = "${module.public-lb-sg.sg_id}"
  security_group_id        = "${module.public-ec2-sg.sg_id}"
}

resource "aws_security_group_rule" "public-ec2-to-public-lb" {
  type                     = "egress"
  from_port                = "${var.app_port}"
  to_port                  = "${var.app_port}"
  protocol                 = "TCP"
  source_security_group_id = "${module.public-ec2-sg.sg_id}"
  security_group_id        = "${module.public-lb-sg.sg_id}"
}

resource "aws_security_group_rule" "public-ec2-egress-443" {
  type              = "egress"
  from_port         = "443"
  to_port           = "443"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.public-ec2-sg.sg_id}"
}

resource "aws_security_group_rule" "public-ec2-egress-80" {
  type              = "egress"
  from_port         = "80"
  to_port           = "80"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.public-ec2-sg.sg_id}"
}

resource "aws_security_group_rule" "ssh-to-public-ec2" {
  type              = "ingress"
  from_port         = "22"
  to_port           = "22"
  protocol          = "TCP"
  cidr_blocks       = ["${var.ec2_ssh_cidr}"]
  security_group_id = "${module.public-ec2-sg.sg_id}"
}

resource "aws_security_group_rule" "internet-to-public-lb" {
  type              = "ingress"
  from_port         = "${var.lb_port}"
  to_port           = "${var.lb_port}"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.public-lb-sg.sg_id}"
}

resource "aws_security_group_rule" "public-lb-to-internet" {
  type              = "egress"
  from_port         = "${var.lb_port}"
  to_port           = "${var.lb_port}"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${module.public-lb-sg.sg_id}"
}
