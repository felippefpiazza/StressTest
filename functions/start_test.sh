#!/bin/bash

cd $1

#for c in $(seq 1 1 $2)
#do
./functions/load.sh $2 &
echo "load.sh $2 --> DONE"
#done
