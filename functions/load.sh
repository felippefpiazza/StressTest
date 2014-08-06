#!/bin/bash
debug=`cat configs/config.txt |grep debug | cut -d"=" -f2`
target_url=`cat bots/$1.txt |grep target_url | cut -d"=" -f2`
post_file=`cat bots/$1.txt |grep post_file | cut -d"=" -f2`

echo $1
echo $target_url
echo $post_file

cont=true

bot_file="bots/$1.txt"; 

while $cont
do

	qtd=`cat tmp/qtd_$1`
	if [ $qtd -lt 0 ]; then
		cont=false
		killall wget
	fi

	runners=`ps awx | grep wget | grep $post_file | grep $target_url | wc -l`;
	if [ $debug -gt 0 ]; then 
		echo "ps awx | grep wget | grep $post_file | grep $target_url | wc -l";
	fi

	echo "$1 | $qtd | $runners " >> ./log/debug


	if [ "$runners" -lt "$qtd" ] ; then
		./functions/insert_request.sh $1
		(time wget $target_url -p --post-file="bots/post/$post_file" -O /dev/null -a log/wget_response.txt) 2>&1 | awk '/real/ {print $2m$3}' | ./functions/insert_response.sh $1  &
		#echo "wget $target_url -p --post-file=\"bots/post/$post_file\" -O /dev/null -a log/wget_response.txt";
		if [ $debug -gt 3 ]; then
			echo "QTD MAXIMA -> $qtd | ROBO -> $1 | RUNNING -> $runners"; 
		fi
	fi
	if [ $debug -gt 3 ]; then
		echo "QTD MAXIMA -> $qtd | ROBO -> $1 | RUNNING -> $runners"; 
	fi
done
