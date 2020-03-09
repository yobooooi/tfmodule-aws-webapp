resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "e2s-instance-profile"
    role = "${aws_iam_role.ec2_instance_role.name}"
}

resource "aws_iam_role" "ec2_instance_role" {
    name               = "ec2-instance-role"
    assume_role_policy = "${data.aws_iam_policy_document.ec2_instance_policy.json}"
}

data "aws_iam_policy_document" "ec2_instance_policy" {
    statement {
        actions = ["sts:AssumeRole"]

        principals {
            type        = "Service"
            identifiers = ["ec2.amazonaws.com"]
        }
    }
}