#!/bin/bash
host=`cat configs/config.txt |grep host | cut -d"=" -f2`
user=`cat configs/config.txt |grep user | cut -d"=" -f2`
pass=`cat configs/config.txt |grep pass | cut -d"=" -f2`
db=`cat configs/config.txt |grep db | cut -d"=" -f2`
debug=`cat configs/config.txt |grep debug | cut -d"=" -f2`

mysql --user=$user --password=$pass -e "select test_name,count(*),avg(tot) from responses where created_at > (NOW() - INTERVAL 1 minute) group by test_name" $db -h $host 2> /dev/null 

if [ $debug -gt 1 ] ; then
	echo "mysql --user=$user --password=$pass -e \"select test_name,count(*),avg(tot) from responses where created_at > (NOW() - INTERVAL 1 minute) group by test_name\" $db -h $host 2> /dev/null "
fi

echo -n "Requests em fila -->"
ps awx | grep wget | grep .txt | wc -l  