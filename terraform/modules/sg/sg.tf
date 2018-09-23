# Create security group
resource "aws_security_group" "sg" {
  name = "${var.app_name}-${var.module_name}"

  # Merge tags from environment tfvars and create name tag
  tags = "${merge(map("Name", "${var.app_name}-${var.module_name}"), var.mytags)}"
}
