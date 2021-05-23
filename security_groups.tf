#
# Security groups that allow for:
# 80 - HTTP connection, 443 - HTTPS connection, 22 - SSH, 2049 - EFS, 3306 - SQL
# FIXME: Remove the [0.0.0.0/0] CIDR blocks and limit to the CIDRS of the subnets
#
resource "aws_security_group" "webapp_sgrp" {
    name = "sgrp-${var.application}"
    description = "Allow incoming HTTP connections."
    vpc_id = var.vpc_id

    ingress {
        from_port = 8
        to_port = 0
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "webapp_db_sgrp" {
    name        = "sgrp-db-${var.application}"
    description = "security group for wordpress RDS"
    vpc_id      = var.vpc_id

    ingress {
        description = "ingress from app sg"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        description = "egress to admin cidrs"
        from_port   = 3306
        to_port     = 3306
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
}
