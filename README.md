## Purpose

The purpose of this module is to create a pattern for deploying a 3 tier Web Application like WordPress.

#### Source Code Structure
_____________________

```bash
├── policies                      <-- Templates for all policies that will be created                 
│   └── s3_policy.json    
├── scripts                       <-- Script thats used in the userdata for launch configuration to mount the efs share
|   └── userdata.sh                  
├── test                          <-- Example of the test case
│   └── test.tf
├── alb.tf                        <-- Application Load Balancer Resources i.e. ALB, Listeners and Target Groups
├── data.tf                       <-- Reading template files to create policies
├── ec2.tf                        <-- EC2 Resouces i.e. Launch Configuration, ASG, userdate
├── efs.tf                        <-- EFS resource and the EFS mounts points in the data subnets
├── iam.tf                        <-- IAM Resources i.e. Roles, Policies and policy attachments
├── rds.tf                        <-- Resources for RDS. RDS instance and Clusters
├── security_groups.tf            <-- Security Groups for the RDS and EC2 instance
└── variables.tf                  <-- Variable used in the module
```

#### Usage of the WebApp Terraform Module
_____________________

```ruby
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
```
### Additional Reading
[WordPress Best Practices](https://aws.amazon.com/blogs/architecture/wordpress-best-practices-on-aws/)


