#!/bin/bash

echo "set region to eu-gb"
ibmcloud target -r eu-gb
ibmcloud is target --gen 2

rm myserverids.txt

ibmcloud is instances | grep "ubuntu-vpc-" | cut -d" " -f1 > myserverids.txt

input="myserverids.txt"
while IFS= read -r line
do
  echo "deleting VSI $line"

ibmcloud is instance-delete $line -f

done < "$input"

