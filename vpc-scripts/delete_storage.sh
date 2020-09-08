#!/bin/bash

echo "set region to eu-gb"
ibmcloud target -r eu-gb
ibmcloud is target --gen 2 

rm mystorageids.txt

ibmcloud is volumes | grep "james-100gb" | cut -d" " -f1 > mystorageids.txt


input="mystorageids.txt"
while IFS= read -r line
do
  echo "deleting STORAGE $line"

ibmcloud is volume-delete $line -f

done < "$input"

