#!/bin/bash

#This script is meant to have two command line arguments
#The first one is the name of the input file that contains the data to preprocess
#The second one contains the output file
#The third one is a flag to activate/deactivate the writing of certain information
rm -f  $2
timestamp=""
cat $1 | { while read -r line
do
        if [[ $line == "/ip"* ]]; then #line that contains the peer info
                ipaddr=$(echo $line | cut -f 3 -d "/")
                port=$(echo $line | cut -f 5 -d "/" | sed 's/[^a-zA-Z0-9]//g')
                if [[ $3 == 0 ]]; then
                        #I get the country from the IP and sanitize it
                        country=$(geoiplookup $ipaddr | cut -f 2 -d ':' | cut -f 2 -d ',' | sed 's/[^a-zA-Z0-9]//g')
                        #I get the ISP from the IP and sanitize it
                        isp=$(curl -s https://www.whoismyisp.org/ip/$ipaddr | grep -oP -m1 '(?<=isp">).*(?=</p)')
                else
                        country=""
                        isp=""
                fi
                curr_id=$(echo $line | cut -f 7 -d "/" | sed 's/[^a-zA-Z0-9]//g')
                echo "$timestamp $curr_id $iptype $ipaddr $port $country $isp" >> $2
        elif [[ $line == *"END"* ]]; then #line that contains the end of a periodic analysis
                :
        else #line that contains date and time information
                timestamp=$(echo $line)
                timestamp="${timestamp:0:16}"
        fi
done
}
