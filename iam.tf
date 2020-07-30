# ec2 instance profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "iam-instance-profile-${var.buen}-${var.environment}-${var.application}"
    role = "${aws_iam_role.ec2_instance_role.name}"
}

# ec2 policy for ssm etc.
resource "aws_iam_role" "ec2_instance_role" {
    name               = "ec2-role-${var.buen}-${var.environment}-${var.application}"
    assume_role_policy = "${data.aws_iam_policy_document.ec2_instance_policy.json}"
}

# ec2 policy to mount efs
resource "aws_iam_policy" "efs_mount_policy" {
    name        = "policy-efs-${var.buen}-${var.environment}-${var.application}"
    description = "Allow EC2 instance to mount efs share"
    policy      = "${data.template_file.efs_mount_permissions_policy.rendered}"
}

# ec2 policy to access the s3 bucket used for deployment
resource "aws_iam_policy" "s3_deployment_bucket_policy" {
    name        = "policy-s3-${var.buen}-${var.environment}-${var.application}"
    description = "Allow EC2 instance to Pull data from S3 Deployment Buck"
    policy      = "${data.template_file.s3_permissions_policy.rendered}"
}

# ec2 policy to use s3:kms key to decrypt objects from S3
resource "aws_iam_policy" "kms_s3_policy" {
    name        = "policy-kms-s3-${var.buen}-${var.environment}-${var.application}"
    description = "Allow EC2 instance to Pull data from S3 Deployment Bucket usings KMS key"
    policy      = "${data.template_file.kms_s3_permissions_policy.rendered}"
}

# attachment commands to attach the policy to the role
resource "aws_iam_role_policy_attachment" "test-attach" {
    role       = "${aws_iam_role.ec2_instance_role.name}"
    policy_arn = "${aws_iam_policy.efs_mount_policy.arn}"
}

# attachment commands to attach the policy to the role
resource "aws_iam_role_policy_attachment" "attach-s3-policy" {
    role       = "${aws_iam_role.ec2_instance_role.name}"
    policy_arn = "${aws_iam_policy.s3_deployment_bucket_policy.arn}"
}

# attachment commands to attach the policy to the role
resource "aws_iam_role_policy_attachment" "ssm-policy" {
    role       = "${aws_iam_role.ec2_instance_role.name}"
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# attachment commands to attach the policy to the role
resource "aws_iam_role_policy_attachment" "s3-kms-policy" {
    role       = "${aws_iam_role.ec2_instance_role.name}"
    policy_arn = "${aws_iam_policy.kms_s3_policy.arn}"
}
