for i in `ls bots/*.txt | cut -d"." -f1 | cut -d"/" -f2`; 
do 
./functions/set_bots.sh  $i $1
done