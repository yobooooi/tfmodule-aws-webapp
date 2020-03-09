resource "aws_launch_configuration" "wordpress_ec2" {
    name                 = "wordpress-ec2-instance-launch-configuration"
    image_id             = "${var.ec2_ami}"
    instance_type        = "${var.ec2_instance_type}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2_instance_profile.id}"

    root_block_device {
        volume_type           = "standard"
        volume_size           = 25
        delete_on_termination = true
    }

    lifecycle {
        create_before_destroy = true
    }

    security_groups             = ["${aws_security_group.app_server.id}"]
    associate_public_ip_address = true

    user_data = "${data.template_file.wordpress_ec2_launch_configuration_userdata.rendered}"
}

resource "aws_autoscaling_group" "wordpress_ec2_autoscaling_group" {
    name                 = "wordpress ec2 autoscaling group"
    max_size             = "2"
    min_size             = "1"
    desired_capacity     = "1"
    vpc_zone_identifier  = "${var.app_subnet}"
    launch_configuration = "${aws_launch_configuration.wordpress_ec2.name}"
    health_check_type    = "EC2"
}


data "template_file" "wordpress_ec2_launch_configuration_userdata" {
    template = "${file("${path.module}/scripts/userdata.sh")}"

}