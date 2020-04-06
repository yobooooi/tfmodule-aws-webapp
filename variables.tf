variable "vpc_id" {
    description = "VPC where the ECS cluster should be deployed"
}

variable "ec2_instance_type" {
    description = ""
    default     = "t2.micro"
}

variable "app_subnet" {
    description = ""
}

variable "data_subnet" {
    description = ""
}

variable "root_block_device" {
    description = ""
    default     = "25"
}

variable "key_name" {
    description = ""
    default     = "wordpress-poc-ec2" 
}

variable "buen" {
    description = ""
}

variable "environment" {
    description = ""
}

variable "application" {
    description = ""
}

variable "family" {
}

variable "cluster_family" {
}

variable "db_family" {
}

variable "db_port" {
}

variable "engine" {
}

variable "engine_version" {
}
variable "db_instance_class" {
}
variable "master_username" {
    default = "wordpressadmin"
}

variable "s3-deployment_bucket_arn" {
}

