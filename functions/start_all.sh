#!/bin/bash

for i in `ls bots/*.txt | cut -d"." -f1 | cut -d"/" -f2`; 
do 
./functions/start_clients.sh  $i
done