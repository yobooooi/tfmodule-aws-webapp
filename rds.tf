resource "aws_db_parameter_group" "wordpressdb_pg" {
    family      = "${var.family}"
    description = "Parameter group for wordpress cluster db instances"
}

resource "aws_rds_cluster_parameter_group" "wordpressdb_cluster_pg" {

    family      = "${var.cluster_family}"
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

resource "aws_rds_cluster" "wordpressdb_cluster" {
    cluster_identifier              = "rds-cluster"
    #vailability_zones              = ["eu-west-1a", "eu-west-1b"]
    storage_encrypted               = true

    engine                          = "${var.engine}"
    engine_version                  = "${var.engine_version}"

    master_username                 = "${var.master_username}"
    master_password                 = "wordpress_demo_password"
    database_name                   = "WPSPAPRDRwanda"

    backup_retention_period         = "5"
    preferred_backup_window         =  "03:00-04:00"
    vpc_security_group_ids          = ["${aws_security_group.rds_sg.id}"]

    preferred_maintenance_window    = "wed:04:00-wed:04:30"

    port                            = "${var.db_port}"
    db_subnet_group_name            = "${aws_db_subnet_group.wordpressdb_sng.id}"
    db_cluster_parameter_group_name = "${aws_rds_cluster_parameter_group.wordpressdb_cluster_pg.id}"

    timeouts {
        create = "20m"
        update = "15m"
        delete = "20m"
    }
}

resource "aws_rds_cluster_instance" "wordpressdb_instance" {
    count                 = 1
    db_subnet_group_name  = "${aws_db_subnet_group.wordpressdb_sng.id}"
    cluster_identifier    = "${aws_rds_cluster.wordpressdb_cluster.id}"
    publicly_accessible   = false
    identifier            = "rds-clstr-instance-${var.buen}-${var.environment}-${var.application}-${count.index}"
    copy_tags_to_snapshot = true
    engine                = "${var.engine}"
    engine_version        = "${var.engine_version}"
    ca_cert_identifier    = "rds-ca-2019"

    instance_class               = "${var.db_instance_class}"
    auto_minor_version_upgrade   = true
    db_parameter_group_name      = "${aws_db_parameter_group.wordpressdb_pg.id}"

    tags = "${merge(
        map("Name", "rds-cluser-${var.buen}-${var.environment}-${var.application}")
        )}"
    }

resource "aws_db_subnet_group" "wordpressdb_sng" {
    description = "Subnet Group for wordpress Db"
    subnet_ids  = "${var.data_subnet}"

    tags = {
        Name = "subnt-grp-${var.buen}-${var.environment}-${var.application}"
    }
}
