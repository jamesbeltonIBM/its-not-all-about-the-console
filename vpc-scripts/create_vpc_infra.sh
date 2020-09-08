#!/bin/bash

echo "####### Creating your VPC Infrastructure ######"

number_requested=$1

echo "starting to create $number_requested block storage volumes......."

./create_storage.sh $number_requested

echo "done creating block storage volumes, giving them a few seconds to complete"

sleep 10

echo "starting to create $number_requested VSIs......"

./create_vsi.sh $number_requested

echo "done creating the VSIs...... waiting one minute for them all to power on"

sleep 5

# check that they have powered on, otherwise the storage won't attach.....

x=1

while true 

do 
 if [[ $(ibmcloud is instances | grep pending) ]]; then
    echo ".... still waiting, going to sleep for another 5 seconds"
    sleep 5
else
    echo "...OK, all powered on!"
      break
	
##	x=$(( $x - 1 ))

fi

done

sleep 5

echo "starting to attach storage to the VSI's"

./attach_storage.sh

echo "done attaching storage" 

sleep 10

echo "OK. Finished"


