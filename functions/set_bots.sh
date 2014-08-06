#!/bin/bash
debug=`cat configs/config.txt |grep debug | cut -d"=" -f2`
#qtd=$2

servers='configs/servers.txt'
bot_file="bots/$1.txt" 

if [ -f "$bot_file" ]
then
	echo $2 > tmp/qtd_$1

	exec 4<$servers
	while read -u4 i ; do
		if ! echo $i | egrep -q '^ *#'
		then
			ip=`echo $i | cut -d" " -f1`
			username=`echo $i | cut -d" " -f2`
			certificate=`echo $i | cut -d" " -f3`
			directory=`echo $i | cut -d" " -f4`		
			if [ $debug -gt 0 ]; then
				echo IP = $ip / USER = $username / CERT = $certificate / DIR = $directory
			fi		
			scp -i certificates/$certificate  tmp/qtd_$1 $username@$ip:$directory/tmp/qtd_$1

			if [ $debug -gt 1 ]; then		
				echo "scp -i certificates/$certificate  tmp/qtd_$1 $username@$ip:$directory/tmp/qtd_$1"
			fi
		fi
	done
else
	echo "$bot_file not found."
fi
