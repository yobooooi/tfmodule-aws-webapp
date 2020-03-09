resource "aws_lb_target_group" "wordpress-tg" {
    name     = "wordpress-target-group"
    port     = 80
    protocol = "HTTP"
    vpc_id   = "${var.vpc_id}"
}

resource "aws_lb" "wordpress-demo" {
    name                       = "wordpress-demo"
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