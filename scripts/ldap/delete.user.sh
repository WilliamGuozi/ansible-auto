#!/bin/bash

USERFILE=list.users

while read LINE; do 
user=`echo $LINE | awk -F"|" '{print $1}'`
ldapdelete -x -w "123456" -D 'cn=root,dc=htrader,dc=cn' "uid=$user,ou=People,dc=htrader,dc=cn"

done < $USERFILE
