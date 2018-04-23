#!/bin/bash
# 将一些命令的权限设置为750
comgroup=wget:vim
declare -i numOfDir=`echo $comgroup | awk -F: '{ print NF }'`

for I in `seq 1 $numOfDir`; do
	comm=`echo $comgroup | cut -d: -f$I`
	Dir=`which $comm`
	chmod -R 750  $Dir
done
