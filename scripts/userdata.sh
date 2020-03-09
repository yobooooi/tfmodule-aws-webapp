#!/bin/bash

sudo yum -y update
sudo yum -y clean all

sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
sudo yum -y install yum-utils
sudo yum-config-manager --enable remi-php56

sudo yum -y install httpd php php-mysql php-gd openssl psmisc tar
sudo yum -y install amazon-efs-utils
sudo yum -y clean all

sudo systemctl start httpd
sudo systemctl enable httpd