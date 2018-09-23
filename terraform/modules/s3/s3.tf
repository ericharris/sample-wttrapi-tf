# Get data about load balancer service account for logging permissions
data "aws_elb_service_account" "main" {}

# Create IAM policy to allow load balancer service account to write to the S3 logging bucket
data "aws_iam_policy_document" "s3_lb_write" {
  policy_id = "s3_lb_write"

  statement = {
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${var.app_name}-${var.module_name}/*"]

    principals = {
      identifiers = ["${data.aws_elb_service_account.main.arn}"]
      type        = "AWS"
    }
  }
}

# Create the S3 logging bucket for ALBs
resource "aws_s3_bucket" "s3" {
  bucket = "${var.app_name}-${var.module_name}"
  acl    = "private"
  policy = "${data.aws_iam_policy_document.s3_lb_write.json}"
  tags   = "${merge(map("Name", "${var.app_name}-${var.module_name}"), var.mytags)}"
}
