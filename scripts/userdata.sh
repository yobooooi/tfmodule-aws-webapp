#!/bin/bash
sudo mkdir -p /data/www/html/${site_name}

aws s3api get-object --bucket wordpress-deployment-bucket --key ${site_name}.zip /data/www/html/${site_name}/${site_name}.zip
unzip /data/www/html/${site_name}/${site_name}.zip -d /data/www/html/${site_name}/ 

aws s3api get-object --bucket wordpress-deployment-bucket --key config/httpd.conf /etc/httpd/conf/httpd.conf
systemctl restart httpd