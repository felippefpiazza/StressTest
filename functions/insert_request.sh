#!/bin/bash
host=`cat configs/config.txt |grep host | cut -d"=" -f2`
user=`cat configs/config.txt |grep user | cut -d"=" -f2`
pass=`cat configs/config.txt |grep pass | cut -d"=" -f2`
db=`cat configs/config.txt |grep db | cut -d"=" -f2`
debug=`cat configs/config.txt |grep debug | cut -d"=" -f2`

mysql --user=$user --password=$pass -e "insert into requests (test_name) values ('$1')" $db -h $host 2> /dev/null

if [ $debug -gt 1 ] ; then 
echo "mysql --user=$user --password=$pass -e \"insert into requests (test_name) values ('$1')\" $db -h $host 2> /dev/null"
fi