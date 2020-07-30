terraform {
  backend "s3" {
    bucket = "sb001-tf-state-bucket"
    key    = "wordpress-poc"
    region = "eu-west-1"
    profile = "sanlam-sb001"
  }
}

provider "aws" {
    region  = "eu-west-1"
    profile = "sanlam-sb001"
}

module "wordpress" {
    source = "../"

    # Networking Vars
    vpc_id                     = "vpc-0306eda6f9928750e"
    app_subnet                 = ["subnet-0539b64619def41d1", "subnet-08a335a2d951f52b3"]
    data_subnet                = ["subnet-08a335a2d951f52b3", "subnet-09527f39c4ff0b8cb"]
    
    # Application Server Vars
    ec2_instance_type          = "t3.medium"
    s3-deployment_bucket_arn   = "arn:aws:s3:::wordpress-deployment-bucket"
    
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

    # Load Balancer Vars
}