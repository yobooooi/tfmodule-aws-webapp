# 
# creating the EFS file system
#
resource "aws_efs_file_system" "wordpress-demo-efs" {
    creation_token = "efs-${var.buen}-${var.environment}-${var.application}"

    tags = {
        Name = "efs-${var.buen}-${var.environment}-${var.application}"
    }
}

# 
# creating mount points in the subnets that the autocaling group deploys the ec2 instances too
#
resource "aws_efs_mount_target" "wordpress-demo-efs-mount-point-sub1" {
    file_system_id  = "${aws_efs_file_system.wordpress-demo-efs.id}"
    subnet_id       = "${var.data_subnet[0]}"
    security_groups = ["${aws_security_group.app_server.id}"]
}
resource "aws_efs_mount_target" "wordpress-demo-efs-mount-point-sub2" {
    file_system_id  = "${aws_efs_file_system.wordpress-demo-efs.id}"
    subnet_id       = "${var.data_subnet[1]}"
    security_groups = ["${aws_security_group.app_server.id}"]
}