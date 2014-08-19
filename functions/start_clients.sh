#!/bin/bash
debug=`cat configs/config.txt |grep debug | cut -d"=" -f2`

servers='configs/servers.txt'

for i in `ls bots/*.txt | cut -d"." -f1 | cut -d"/" -f2`; 
do 
	./functions/set_bots.sh $i 0;
done

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
		echo Bringing Server $ip UP
		ssh -i certificates/$certificate  $username@$ip -f "$directory/functions/start_test.sh $directory"

		if [ $debug -gt 1 ]; then		
			echo "ssh -i certificates/$certificate  $username@$ip -f \"$directory/functions/start_test.sh $directory\""
		fi
	fi
done

