#!/bin/bash

USERFILE=list.groups
USERFILELDAP=groups.ldif

[ -e $GROUPFILELDAP ] && echo "" > $GROUPFILELDAP || touch $GROUPFILELDAP
count=999
while read LINE; do 
group=`echo $LINE | awk -F : '{print $1}'`
count=$[$count+1]
cat >> $USERFILELDAP << EOF
dn: cn=$group,ou=Group,dc=htrader,dc=cn
objectClass: posixGroup
objectClass: top
cn: $group
userPassword: {crypt}x
gidNumber: $count

EOF
done < $USERFILE
