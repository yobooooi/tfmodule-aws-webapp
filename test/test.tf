terraform {
  backend "s3" {
    bucket  = "enveldemo-tfstate"
    key     = "webapp"
    region  = "eu-west-1"
    profile = "internal-dev"
  }
}
provider "aws" {
  region  = "eu-west-1"
  profile = "internal-dev"
  default_tags {
    tags = {
      "Environment"       = "Development"
      "Owner"             = "Adan"
      "Project"           = "EnvelDemo"
      "Terraform_Managed" = "True"
    }
  }
}

module "webapp" {
  source = "../"

  vpc_id            = "vpc-04f99e5833c3a909b"
  app_subnet        = ["subnet-0e3c6194859275f16", "subnet-04e5b9adfdcabcdaf"]
  data_subnet       = ["subnet-02a3c9740982cc1bb", "subnet-0ea2c57df4538b887"]
  ec2_instance_type = "t3.medium"
  family            = "aurora-mysql5.7"
  db_family         = "aurora-mysql5.7"
  db_port           = 3306
  cluster_family    = "aurora-mysql5.7"
  engine            = "aurora-mysql"
  engine_version    = "5.7.mysql_aurora.2.03.2"
  db_instance_class = "db.t3.medium"
  application       = "EnvelDemo"
}

output "launch_configuration_id" {
  value = module.webapp.launch_configuration_id
}
output "autoscaling_group_id" {
  value = module.webapp.autoscaling_group_id
}
output "aws_ami_id" {
  value = module.webapp.aws_ami_id
}
output "aws_ami_name" {
  value = module.webapp.aws_ami_name
}