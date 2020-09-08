#!/bin/bash

echo "####### Creating 100GB Block Storage ######"


echo "set region to eu-gb"
ibmcloud target -r eu-gb
ibmcloud is target --gen 2 

ibmcloud target -g VPC-RG

echo "set vpc"
vpc=$MYVPCID
echo $vpc

echo "set subnet"
subnet=$MYSUBNETID
echo $subnet 


x=1

while [ $x -le $1 ]
do

echo "Creating block storage $x"

ibmcloud is volume-create james-100gb-vol-$x general-purpose eu-gb-1 --capacity 100 --resource-group-name VPC-RG 


x=$(( $x + 1 ))

done

echo "####### Finished Creating Block Storage ######"
