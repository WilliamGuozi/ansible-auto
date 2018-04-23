#!/bin/bash
# 将PATH中所有命令设置为750
declare -i numOfDir=`echo $PATH | awk -F: '{ print NF }'`

for I in `seq 1 $numOfDir`; do
	Dir=`echo $PATH | cut -d: -f$I`
	chmod -R 755  $Dir
done
