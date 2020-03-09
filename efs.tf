resource "aws_efs_file_system" "wordpress-demo-efs" {
    creation_token = "wordpress-demo-efs"

    tags = {
        Name = "wordpress-content"
    }
}

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