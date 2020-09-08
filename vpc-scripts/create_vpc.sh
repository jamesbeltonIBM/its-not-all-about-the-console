#!/bin/bash

if [ $# -eq 2 ] 
then
    echo $1
else
    echo "Usage is ./create_vpc.sh vpc_name x - where x is the number of VSIs you want to create "
    exit 1
fi


echo "set region to eu-gb"
ibmcloud target -r eu-gb
ibmcloud is target --gen 2

ibmcloud target -g VPC-RG

echo 'Creating VPC named $1' 

ibmcloud is vpcc $1

export MYVPCID=`ibmcloud is vpcs | grep "$1" | cut -d" " -f1`

echo $MYVPCID

# Create a public gateway

ibmcloud is public-gateway-create $1-zone1-pub-gw $MYVPCID eu-gb-1

export MYPGWID=`ibmcloud is public-gateways | grep "$1-zone1-pub-gw" | cut -d" " -f1`


# Create a subnet

ibmcloud is subnet-create $1-zone1-subnet $MYVPCID --ipv4-address-count 256 --zone eu-gb-1 --public-gateway-id $MYPGWID

export MYSUBNETID=`ibmcloud is subnets | grep "$1-zone1-subnet" | cut -d" " -f1`

echo $MYSUBNETID


./create_vpc_infra.sh $2 
