#!/bin/bash

sudo mkdir -p /data/www/html/rwsanlam

aws s3api get-object --bucket wordpress-deployment-bucket --key rwsanlam.zip /data/www/html/rwsanlam/rwsanlam.zip
unzip /data/www/html/rwsanlam/rwsanlam.zip -d /data/www/html/rwsanlam/ 

aws s3api get-object --bucket wordpress-deployment-bucket --key config/httpd.conf /etc/httpd/conf/httpd.conf
systemctl restart httpd