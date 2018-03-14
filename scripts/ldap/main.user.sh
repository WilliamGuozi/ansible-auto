#!/bin/bash

USERFILE=list.users
USERFILELDAP=users.ldif

[ -e $USERFILELDAP ] && echo "" > $USERFILELDAP || touch $USERFILELDAP

while read LINE; do 
user=`echo $LINE | awk -F"|" '{print $1}'`
name=`echo $LINE | awk -F"|" '{print $2}'`
cat >> $USERFILELDAP << EOF
dn: uid=$user,ou=People,dc=htrader,dc=cn
uid: $user
cn: $name
sn: $user
mail: $user@htrader.cn
objectClass: person
objectClass: organizationalPerson
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: top
objectClass: shadowAccount
userPassword: {crypt}\$6\$.IBDppyB\$DVqMlcSdDczQ6uJvqnrVBDKsuGOIUja7V3hxqUrwkxc4CKnWJV8UroZElTJh6Tdfeh7EW/SFCbASZgL4QFJ8a.
shadowLastChange: 17557
shadowMin: 0
shadowMax: 99999
shadowWarning: 7
loginShell: /bin/bash
uidNumber: 1000
gidNumber: 1000
homeDirectory: /home/$user

EOF
done < $USERFILE
