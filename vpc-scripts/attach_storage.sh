#!/bin/bash

echo "set region to eu-gb"
ibmcloud target -r eu-gb
ibmcloud is target --gen 2 

rm myserverids.txt
rm mystorageids.txt

ibmcloud is instances | grep "ubuntu-vpc-" | cut -d" " -f1 > myserverids.txt

ibmcloud is volumes | grep "james-100gb" | cut -d" " -f1 > mystorageids.txt

x=1

paste -d@ myserverids.txt mystorageids.txt | while IFS="@" read -r f1 f2 
do

echo "ibmcloud is instance-volume-attachment-add volume-attach-$x $f1 $f2 --auto-delete true"

ibmcloud is instance-volume-attachment-add volume-attach-$x $f1 $f2 --auto-delete true

x=$(( $x + 1 ))

done

