#!/bin/bash
host=`cat configs/config.txt |grep host | cut -d"=" -f2`
user=`cat configs/config.txt |grep user | cut -d"=" -f2`
pass=`cat configs/config.txt |grep pass | cut -d"=" -f2`
db=`cat configs/config.txt |grep db | cut -d"=" -f2`
debug=`cat configs/config.txt |grep debug | cut -d"=" -f2`



in=$(cat)
m=`echo $in | cut -d"m" -f1`
s=`echo $in | cut -d"m" -f2| cut -d"s" -f1`
tot=`awk "BEGIN { print ( ( $m * 60 ) + $s  ) }"`
t=$1

if [ $debug -gt 0 ] ; then 
	echo TESTE $t
	echo MINUTO $m
	echo SEGUNDO $s
	echo TOTAL $tot
fi

mysql --user=$user --password=$pass -e "insert into responses (test_name,min,sec,tot) values (\"$t\",$m,$s,$tot)" $db -h $host 2> /dev/null

if [ $debug -gt 1 ] ; then 
echo "mysql --user=$user --password=$pass -e \"insert into responses (test_name,min,sec,tot) values (\"$t\",$m,$s,$tot)\" $db -h $host 2> /dev/null"
fi