#!/bin/bash

##delete banckup file and log file

dirapplog=/srv/logs
dirbackup=/srv/qjdchina.com/backup
dirtomcatlog=/srv/qjdchina.com/tomcatserver
tomcatdirlog=logs

echo 删除应用日志文件
rm -fr $dirapplog/*

echo 删除所有tomcat日志
for n in `find $dirtomcatlog -name $tomcatdirlog -type d`;do rm -rf ${n}/*;done

echo 删除3天之前的备份文件
find $dirbackup/ -type d -ctime +3 -exec rm -rf {} \;

