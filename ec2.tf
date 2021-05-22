#
# the launch configuration for the ec2 instance. this is where your instance condiguration is created
# i.e. security groups, instance type, AMI, userdata etc.
# FIXME: launch without public IP

resource "aws_launch_configuration" "wordpress_ec2" {
    image_id             = "${data.aws_ami.wordpress-image.id}"
    instance_type        = "${var.ec2_instance_type}"
    iam_instance_profile = "${aws_iam_instance_profile.ec2_instance_profile.id}"

    root_block_device {
        volume_type           = "standard"
        volume_size           = "${var.root_block_device}"
        delete_on_termination = true
    }

    lifecycle {
        create_before_destroy = true
    }

    security_groups             = ["${aws_security_group.app_server.id}"]
    associate_public_ip_address = true

    user_data = "${data.template_file.wordpress_ec2_launch_configuration_userdata.rendered}"
}

#
# creating autoscaling group and associating it to the target group cofigured for the
# application load balancer
#
resource "aws_autoscaling_group" "wordpress_ec2_autoscaling_group" {
    name                 = "asg-${var.buen}-${var.environment}-${var.application}"
    max_size             = "2"
    min_size             = "1"
    desired_capacity     = "1"
    vpc_zone_identifier  = "${var.app_subnet}"
    launch_configuration = "${aws_launch_configuration.wordpress_ec2.name}"
    health_check_type    = "EC2"
    target_group_arns    = ["${aws_lb_target_group.wordpress-tg.arn}"]

    # tags used to launch the ec2 instance with
    tag {
        key                 = "Name"
        value               = "asg-ec2-${var.buen}-${var.environment}-${var.application}"
        propagate_at_launch = true
    }

}

#
# using a template resource to create the userdata used to launch the ec2 instances in the 
# launch configuration. Note that the launch configuration isn't named, terraform will manage this 
# on our behalf, so when destroying or replacing there are no conflicts or duplicate resources
# TODO: add entry in fstab to make sure that the EFS share is mounted on boot
data "template_file" "wordpress_ec2_launch_configuration_userdata" {
    template = "${file("${path.module}/scripts/userdata.sh")}"
    
    vars = {
        efs_id     = "${aws_efs_file_system.wordpress-demo-efs.id}"
    }
}

#
# sourcing the ami for the wordpress ec2 instances. Note, when sharing the AMI across acconts ensure the
# naming convention applies for it to be able to get an AMI that matches the filter below
#
data "aws_ami" "wordpress-image" {
    most_recent = true
    owners = ["777120396959"]
    
    filter {
        name   = "tag:Name"
        values = ["dev-wordpress-latest-AMZN-baseimage-*"]
    }
}