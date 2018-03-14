#!/bin/bash

USERFILE=list.add_user_to_group
USERFILELDAP=add_user_to_groups.ldif

[ -e $GROUPFILELDAP ] && echo "" > $GROUPFILELDAP || touch $GROUPFILELDAP

while read LINE; do 
name=`echo $LINE | awk -F"|" '{print $1}'`
group=`echo $LINE | awk -F"|" '{print $2}'`

cat >> $USERFILELDAP << EOF
dn: cn=$group,ou=Group,dc=htrader,dc=cn
changetype: modify
add: memberuid
memberuid: $name

EOF
done < $USERFILE
