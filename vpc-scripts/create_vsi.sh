#!/bin/bash

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

echo "set key - mylondonkey"
key=r018-76b6fa68-aa99-4752-99e4-c56a8ba31ae0
echo $key


echo "set image"
image=$(ibmcloud is images |grep available |grep "ubuntu-18-04-amd64" | cut -d" " -f1)
echo $image

x=1

while [ $x -le $1 ]
do

echo "Creating VSI number $x"


### this command creates the VSI

ibmcloud is instance-create ubuntu-vpc-$x $vpc eu-gb-1 bx2-2x8 $subnet --image-id $image --key-ids $key --user-data @run_commands.sh --resource-group-name VPC-RG


x=$(( $x + 1 ))

done
