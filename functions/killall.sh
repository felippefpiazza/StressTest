#!/bin/bash


for i in `ls tmp* | cut -d"_" -f2`; 
do 
./functions/set_bots.sh $i -1
done