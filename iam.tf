resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "e2s-instance-profile"
    role = "${aws_iam_role.ec2_instance_role.name}"
}

resource "aws_iam_role" "ec2_instance_role" {
    name               = "ec2-instance-role"
    assume_role_policy = "${data.aws_iam_policy_document.ec2_instance_policy.json}"
}

resource "aws_iam_policy" "efs_mount_policy" {
    name        = "efs_mount_policy"
    description = "Allow EC2 instance to mount efs share"
    policy      = "${data.template_file.efs_mount_permissions_policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "test-attach" {
    role       = "${aws_iam_role.ec2_instance_role.name}"
    policy_arn = "${aws_iam_policy.efs_mount_policy.arn}"
}