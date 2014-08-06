#!/bin/bash
debug=`cat configs/config.txt |grep debug | cut -d"=" -f2`
keepup=true

function print_manual(){
	echo "Available options:"
	echo "launch <VALUE>--> Launch the Bots of the kind <VALUE>"
	echo "launch_all --> Launches all the Bots"
	echo "qtd <BOT IDENTIFICATION> <VALUE> --> set the concurrent bots to be launched for each kind"
	echo "qtd_all <VALUE> --> set the concurrent bots to all launched bots"
	echo "stop <BOT IDENTIFICATION> --> Stop launching bots, but keep the clients on the servers on hold"
	echo "killall --> Stop launching bots and lets the clients on the servers die"
	echo "exit --> Exit the bot control central"
	echo "deploy --> Deploy the configuration and files to a bot server"
	echo "stats --> Show statistics of the last minute"
	echo "? --> Shows this manual"
	echo "clear --> Cleans the screen"
}

print_manual
while $keepup
do
	sleep 1
	echo "Type your command (or "?" for more information):"
	read input

	first=`echo $input | cut -d" " -f1`
	second=`echo $input | cut -d" " -f2`
	third=`echo $input | cut -d" " -f3`

	case $first in 
		"launch") ./functions/start_clients.sh $second;;
		"launch_all") ./functions/start_all.sh;;
		"qtd") ./functions/set_bots.sh $second $third ;;
		"qtd_all") ./functions/set_all_bots.sh $second;;
		"killall") ./functions/killall.sh;;
		"stop") ./functions/set_bots.sh $second 0;;
		"exit") keepup=false;;
		"deploy") ./functions/setup_servers.sh;;
		"stats") ./functions/response_per_minute.sh;;
		"?") print_manual;;
		"clear") clear ;;
		*) echo "Invalid...." ; print_manual;;
	esac
	
done