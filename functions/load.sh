#!/bin/bash
debug=`cat configs/config.txt |grep debug | cut -d"=" -f2`

unset bot_count
unset robot_name
unset target_url
unset post_file
bot_count=0
for i in `ls bots/*.txt | cut -d"." -f1 | cut -d"/" -f2`; 
do 
	robot_name[$bot_count]=$i
	target_url[$bot_count]=`cat bots/$i.txt |grep target_url | cut -d"=" -f2`
	post_file[$bot_count]=`cat bots/$i.txt |grep post_file | cut -d"=" -f2`
	bot_count=`expr $bot_count + 1`
done

cont=true

while $cont
do
	ps=`ps awx | grep wget`
	unset qtd
	count=0
	while [ $count -lt $bot_count ]
	do
		./functions/run_test.sh ${robot_name[$count]} ${target_url[$count]} ${post_file[$count]} $count &

		#if [ $debug -gt 3 ]; then
		#	echo "QTD MAXIMA -> ${qtd[$count]} | ROBO -> ${robot_name[$count]} | RUNNING -> ${runners[$count]}"; 
		#fi

		count=`expr $count + 1`
	done
done
