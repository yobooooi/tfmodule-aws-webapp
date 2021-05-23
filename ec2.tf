resource "aws_launch_configuration" "webapp_launchconf" {
    image_id             = data.aws_ami.webapp_ami.id
    instance_type        = var.ec2_instance_type
    iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.id

    root_block_device {
        volume_type           = "standard"
        volume_size           = var.root_block_device
        delete_on_termination = true
    }

    lifecycle {
        create_before_destroy = true
    }

    security_groups             = [aws_security_group.webapp_sgrp.id]
    associate_public_ip_address = true

    user_data = data.template_file.webapp_lauchconf_userdata.rendered
}

resource "aws_autoscaling_group" "webapp_asg" {
    name                 = "asg-${var.application}"
    max_size             = "2"
    min_size             = "1"
    desired_capacity     = "1"
    vpc_zone_identifier  = var.app_subnet
    launch_configuration = aws_launch_configuration.webapp_launchconf.name
    health_check_type    = "EC2"
    target_group_arns    = [aws_lb_target_group.webapp_tg.arn]

    instance_refresh {
        strategy = "Rolling"
    }
    tag {
        key                 = "Name"
        value               = "asg-ec2-${var.application}"
        propagate_at_launch = true
    }

}
data "template_file" "webapp_lauchconf_userdata" {
    template = file("${path.module}/scripts/userdata.sh")
}

data "aws_ami" "webapp_ami" {
    most_recent = true
    owners = ["296274010522"]
    
    filter {
        name   = "tag:codebuild_id"
        values = ["codebuild-enveldemo-wordpress-ami-pipeline:*"]
    }
}