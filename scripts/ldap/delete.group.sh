#!/bin/bash

USERFILE=list.groups

while read LINE; do 
group=`echo $LINE | awk -F"|" '{print $1}'`
ldapdelete -x -w "123456" -D 'cn=root,dc=htrader,dc=cn' "cn=$group,ou=Group,dc=htrader,dc=cn"

done < $USERFILE
