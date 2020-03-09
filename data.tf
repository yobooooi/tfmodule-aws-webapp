data "aws_iam_policy_document" "ec2_instance_policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}


data "template_file" "efs_mount_permissions_policy" {
    template = "${file("${path.module}/policies/efs_policy.json")}"

    vars = {
        efs_arn = "${aws_efs_file_system.wordpress-demo-efs.arn}"
    }
}