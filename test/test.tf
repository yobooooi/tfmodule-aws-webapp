provider "aws" {
    region  = "eu-west-1"
    profile = "sanlam-sb004"
}

module "wordpress" {
    source = "../"

    # Networking Vars
    vpc_id                     = "vpc-000635fd1f3740847"
    app_subnet                 = ["subnet-0401fc7c92842fb29", "subnet-0c98250e5021cc00c"]
    data_subnet                = ["subnet-0401fc7c92842fb29", "subnet-0c98250e5021cc00c"]
    
    # Application Server Vars
    ec2_instance_type          = "t3.medium"
    s3-deployment_bucket_arn   = "arn:aws:s3:::s3-sgti-sbx-sgti-st-sb004-deployment"
    
    # Database Vars
    family                     = "aurora-mysql5.7"
    db_family                  = "aurora-mysql5.7"
    db_port                    = 3306
    cluster_family             = "aurora-mysql5.7"
    engine                     = "aurora-mysql"
    engine_version             = "5.7.mysql_aurora.2.03.2"
    db_instance_class          = "db.t3.medium"

    # Business Vars
    environment                = "poc"
    buen                       = "sgti"
    application                = "wordpress"
    site_name                  = "rwsanlam"

    # Load Balancer Vars
}