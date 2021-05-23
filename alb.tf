resource "aws_lb_target_group" "webapp_tg" {
    name     = "alb-tg-${var.application}"
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
}

resource "aws_lb" "webapp_alb" {
    name                       = "alb-${var.application}"
    internal                   = false
    load_balancer_type         = "application"
    security_groups            = [aws_security_group.webapp_sgrp.id]
    subnets                    = var.app_subnet
    enable_deletion_protection = false
}

resource "aws_lb_listener" "alb-listener" {
    load_balancer_arn = aws_lb.webapp_alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.webapp_tg.arn
    }
}