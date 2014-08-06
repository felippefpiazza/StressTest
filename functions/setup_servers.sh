#!/bin/bash
debug=`cat configs/config.txt |grep debug | cut -d"=" -f2`


servers='configs/servers.txt'


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
		ssh -i certificates/$certificate $username@$ip mkdir -p $directory
		scp -r -i certificates/$certificate  * $username@$ip:$directory
		if [ $debug -gt 1 ]; then		
			echo "ssh -i certificates/$certificate $username@$ip mkdir -p $directory"
			echo "scp -r -i certificates/$certificate  * $username@$ip:$directory"
		fi
	fi
done