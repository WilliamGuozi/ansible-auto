#!/bin/bash
# 设置命令的权限为750
# 用法:将需要去除普通用户权限的命令写到comgroup，以:分割
# 使用ansible批量修改，例如: ansible all -m script -a "setCommTo750-comm.sh"
# 
#用户列表
usergroup=dev:dba:test
#命名列表
comgroup=wget:scp:ftp:sftp:sfdp:rz:sz:curl:rcp:rsync
#服务列表
sergroup=sftp-server

#用户个数
declare -i numOfUser=`echo $usergroup | awk -F: '{ print NF }'`
#命令个数
declare -i numOfCom=`echo $comgroup | awk -F: '{ print NF }'`
#服务个数
declare -i numOfSer=`echo $sergroup | awk -F: '{ print NF }'`

#遍历每一个用户
for J in `seq 1 $numOfUser`; do
	user=`echo $usergroup | cut -d: -f$J`
	
	#遍历每一个命名
	for I in `seq 1 $numOfCom`; do
		comm=`echo $comgroup | cut -d: -f$I`
		Dir=`which $comm`
		#使用setfacl，限制该用户的访问权限
		setfacl -m u:$user:r $Dir
	done
	
	#遍历每一服务
	for I in `seq 1 $numOfSer`; do
        	ser=`echo $sergroup | cut -d: -f$I`
		#关闭服务
		pkill $ser
	        Dir=`find / -name $ser`
		#使用setfacl，限制该服务访问权限
	        setfacl -m u:$user:r $Dir
	done
done
