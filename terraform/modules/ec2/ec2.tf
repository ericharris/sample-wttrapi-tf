# Create EC2 instance for webserver
resource "aws_instance" "ec2" {
  ami           = "${var.ec2_ami}"
  key_name      = "webapp"                     // Use "webapp" AWS key pair for instance
  instance_type = "${var.ec2_instance_type}"

  # Merge tags from environment tfvars and create name tag
  tags                   = "${merge(map("Name", "${var.app_name}-${var.module_name}"), var.mytags)}"
  vpc_security_group_ids = ["${var.vpc_sg}"]

  # Setup provisioner connection method
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("../../secrets/webapp.pem")}" // Location of "webapp" pem file on local system
  }

  # Remote execution provisioner to install wttr
  provisioner "file" {
    source      = "wttr-setup.sh"
    destination = "/home/ec2-user/wttr-setup.sh"
  }
  provisioner remote-exec {
    inline = [
      "sh wttr-setup.sh",
    ]
  }
}
