#!/bin/bash

qtd[$4]=`cat tmp/qtd_$1`
runners[$4]=`echo $ps | grep $3 | grep $2 | wc -l`;
#if [ $debug -gt 0 ]; then 
#	echo "echo $ps | grep ${post_file[$4]} | grep ${target_url[$4]} | wc -l";
#fi

if [ ${qtd[$4]} -lt 0 ]; then
	cont=false
	killall wget
fi

how_many=`expr ${qtd[$4]} - ${runners[$4]}`
echo "$1 | ${qtd[$4]} | ${runners[$4]} | Launching $how_many" >> ./log/debug
c[$4]=0
while [ ${c[$4]} -lt $how_many ]
do
	./functions/insert_request.sh $1
	(time wget $2 -p --post-file="bots/post/$3" -O /dev/null -a log/wget_response.txt) 2>&1 | awk '/real/ {print $2m$3}' | ./functions/insert_response.sh $1  &
#	(time curl -X POST -o /dev/null -d @bots/post/$3 $2) 2>&1 | awk '/real/ {print $2m$3}' | ./functions/insert_response.sh $1  &
	c[$4]=`expr ${c[$4]} + 1`
	echo "Subindo robo para $1 || qtd --> ${c[$4]}/$how_many " >> ./log/debug
done