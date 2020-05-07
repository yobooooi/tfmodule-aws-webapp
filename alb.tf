resource "aws_lb_target_group" "wordpress-tg" {
    name     = "alb-tg-${var.buen}-${var.environment}-${var.application}"
    port     = 80
    protocol = "HTTP"
    vpc_id   = "${var.vpc_id}"
}

resource "aws_autoscaling_attachment" "main" {
  autoscaling_group_name = "${aws_autoscaling_group.wordpress_ec2_autoscaling_group.id}"
  alb_target_group_arn   = "arn:aws:elasticloadbalancing:eu-west-1:872120996826:targetgroup/tf-20200423080001650700000001/afa74b3eb548fa3e"
}