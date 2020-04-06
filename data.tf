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

data "template_file" "s3_permissions_policy" { 

    template = "${file("${path.module}/policies/s3_policy.json")}"

    vars = {
        s3_arn = "${var.s3-deployment_bucket_arn}"
    }
}
