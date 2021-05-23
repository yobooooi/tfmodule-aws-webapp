resource "aws_db_parameter_group" "webapp_db_pg" {
    family      = var.family
    description = "Parameter group for wordpress cluster db instances"
}

resource "aws_rds_cluster_parameter_group" "webapp_db_cluster_pg" {

    family      = var.cluster_family
    description = "Parameter group for wordpress cluster"

    parameter {
        name  = "character_set_database"
        value = "utf8mb4"
    }

    parameter {
        name  = "character_set_server"
        value = "utf8mb4"
    }

    parameter {
        name  = "collation_server"
        value = "utf8mb4_unicode_ci"
    }
    }

resource "aws_rds_cluster" "webapp_db_cluster" {
    cluster_identifier              = "rds-cluster"
    #vailability_zones              = ["eu-west-1a", "eu-west-1b"]
    storage_encrypted               = true

    engine                          = var.engine
    engine_version                  = var.engine_version

    master_username                 = var.master_username
    master_password                 = "webapp_password"
    database_name                   = "webapp"

    backup_retention_period         = "5"
    preferred_backup_window         =  "03:00-04:00"
    vpc_security_group_ids          = [aws_security_group.webapp_db_sgrp.id]

    preferred_maintenance_window    = "wed:04:00-wed:04:30"

    port                            = var.db_port
    db_subnet_group_name            = aws_db_subnet_group.webapp_db_sng.id
    db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.webapp_db_cluster_pg.id

    timeouts {
        create = "20m"
        update = "15m"
        delete = "20m"
    }
}

resource "aws_rds_cluster_instance" "webapp_db_instance" {
    count                 = 1
    db_subnet_group_name  = aws_db_subnet_group.webapp_db_sng.id
    cluster_identifier    = aws_rds_cluster.webapp_db_cluster.id
    publicly_accessible   = false
    identifier            = "rds-clstr-instance-${lower(var.application)}-${count.index}"
    copy_tags_to_snapshot = true
    engine                = var.engine
    engine_version        = var.engine_version
    ca_cert_identifier    = "rds-ca-2019"

    instance_class               = var.db_instance_class
    auto_minor_version_upgrade   = true
    db_parameter_group_name      = aws_db_parameter_group.webapp_db_pg.id
    tags = {
        Name = "rds-cluser-${lower(var.application)}"
    }
}

resource "aws_db_subnet_group" "webapp_db_sng" {
    description = "Subnet Group for wordpress Db"
    subnet_ids  = var.data_subnet

    tags = {
        Name = "subnt-grp-${var.application}"
    }
}
