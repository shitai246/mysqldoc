#!/bin/sh
## base config
MYSQL_HOME=/usr/bin/mysql 
MYSQL_USER=user
MYSQL_PASSWD=password
MYSQL_HOST="hoge.com"

OUTPUT_DIR="/var/www/html/mysqldoc"

## 
MYSQL="${MYSQL_HOME} -u ${MYSQL_USER} -p${MYSQL_PASSWD} -h ${MYSQL_HOST}"
DATABASES=`echo "show databases;" | ${MYSQL} -s | grep -v mysql | grep -v information_schema | grep -v performance_schema | grep -v tmp`

