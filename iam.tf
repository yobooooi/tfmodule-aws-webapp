resource "aws_iam_instance_profile" "ec2_instance_profile" {
    name = "iam-instance-profile-${var.application}"
    role = aws_iam_role.ec2_instance_role.name
}
resource "aws_iam_role" "ec2_instance_role" {
    name               = "ec2-role-${var.application}"
    assume_role_policy = data.aws_iam_policy_document.ec2_instance_policy.json
}
resource "aws_iam_role_policy_attachment" "attachment_ec2_instance_role_ssm_policy" {
    role       = aws_iam_role.ec2_instance_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

