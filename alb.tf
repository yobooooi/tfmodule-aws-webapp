resource "aws_lb_target_group" "wordpress-tg" {
    name     = "alb-tg-${var.buen}-${var.environment}-${var.application}"
    port     = 80
    protocol = "HTTP"
    vpc_id   = "${var.vpc_id}"
}

resource "aws_lb" "wordpress-demo" {
    name                       = "alb-${var.buen}-${var.environment}-${var.application}"
    internal                   = false
    load_balancer_type         = "application"
    security_groups            = ["${aws_security_group.app_server.id}"]
    subnets                    = "${var.app_subnet}"
    enable_deletion_protection = false

    tags = {
        Environment = "wordpress-demo"  
    }
}

resource "aws_lb_listener" "alb-listener" {
    load_balancer_arn = "${aws_lb.wordpress-demo.arn}"
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = "${aws_lb_target_group.wordpress-tg.arn}"
    }
}

# code to attach autoscaling group to an existing application load balancer 
#
# resource "aws_autoscaling_attachment" "main" {
#   autoscaling_group_name = "${aws_autoscaling_group.wordpress_ec2_autoscaling_group.id}"
#   alb_target_group_arn   = "arn:aws:elasticloadbalancing:eu-west-1:872120996826:targetgroup/tf-20200423080001650700000001/afa74b3eb548fa3e"
# }