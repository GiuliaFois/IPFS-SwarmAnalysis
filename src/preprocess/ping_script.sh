#!/bin/bash

#This script is meant to have two command line arguments
#The first one is the file to read the IP addresses from
#The second one is the output file
rm -f $2
cat $1 | { while read -r line
do
	echo "Ping a IP $line ..."
	pinglines=$(ping -c 5 $line)
	rtt_stats=$(echo $pinglines | awk -F"rtt" '{print $2}')
	echo "$line rtt $rtt_stats" >> $2 
done
}
