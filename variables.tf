variable "vpc_id" {
    description = "VPC where the ECS cluster should be deployed"
}

variable "ec2_instance_type" {
    description = "Instance Type"
    default     = "t2.micro"
}

variable "app_subnet" {
    description = "The subnet in which to deploy launch the ALB, EC2 instances"
}

variable "data_subnet" {
    description = "The subnet in which to deploy the RDS too and the EFS file share"
}

variable "root_block_device" {
    description = "The size of the root volumes for the EC2 instances"
    default     = "25"
}

#FIXME: use the tagging and naming module
variable "buen" {
    description = "Tags taken from the Sanlam Standards Document"
}

#FIXME: use the tagging and naming module
variable "environment" {
    description = "Tags taken from the Sanlam Standards Document"
}

#FIXME: use the tagging and naming module
variable "application" {
    description = "Tags taken from the Sanlam Standards Document"
}

variable "family" {
    description = "Cluster family i.e aurora-mysql5.7"
}

variable "cluster_family" {
    description = "Cluster family i.e aurora-mysql5.7"
}

variable "db_family" {
    description = "DB family i.e aurora-mysql5.7"
}

variable "db_port" {
    description = "Port on which to expose the RDS DB on"
}

variable "engine" {
    description = "Engine that the RDS DB must use i.e. aurora-mysql"
}

variable "engine_version" {
    description = "Version of the engine that the RDS DB must use i.e. 5.7.mysql_aurora.2.03.2"
}
variable "db_instance_class" {
    description = "Instance type that the RDS should be provisioned with i.e. db.t3.medium" 
}
#TODO: make use of SSM Parameter store or something more secure
variable "master_username" {
    default = "wordpressadmin"
}

variable "s3-deployment_bucket_arn" {
    description = "ARN of the S3 bucket used for Deployment"
}