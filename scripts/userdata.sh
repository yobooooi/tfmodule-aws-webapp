#! /bin/bash

yum -y update
yum clean all

yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum -y install yum-utils
yum-config-manager --enable remi-php56

yum -y install httpd php php-mysql php-gd openssl psmisc tar
yum clean all