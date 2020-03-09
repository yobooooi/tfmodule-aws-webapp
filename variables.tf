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

variable "ec2_ami" {
    description = ""
}

variable "key_name" {
    description = ""
    default     = "wordpress-ec2" 
}
