provider "aws" {
    region  = "us-east-2"
    profile = "synthesis-dev"
}

module "wordpress" {
    source = "../"

    vpc_id      = "vpc-042aef62c68ce9210"
    app_subnet  = ["subnet-030e001711c8e3487", "subnet-0b15e812b0a8c79dd"]
    data_subnet = ["subnet-054285ff14bfeccdf", "subnet-018597d905e936821"]
    ec2_ami     = "ami-0e38b48473ea57778"
}
