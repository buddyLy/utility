#!/bin/bash

function setStatus
{
	
	capability=$1 
	capabilityId=$2
	status=$3
	#todo, capabilty, capability code, status
	java -jar ao-oracle-interface.jar setstatus $capability $capabilityId $status
}

function insertFiles
{
	capability=$1 
	capabilityId=$2
	#todo, capabilty, capability code
	java -jar ao-oracle-interface.jar insertfiles $capability $capabilityId
} 

function retrieve 
{
	assortmentID=$1
	java -jar ao-oracle-interface.jar retrieve $assortmentID
} 


function retrieveBlob
{
	java -jar ao-oracle-interface.jar retrieveblob 992 401 "/Users/lcle/tmp/excel6.csv"
}

whatyouwannado=$1
assortID=$2

if [[ $whatyouwannado == "retrieve" ]];then
	retrieve $assortID
elif [[ $whatyouwannado == "insertfiles" ]];then
	insertFiles "loyalty" "223"
elif [[ $whatyouwannado == "setstatus" ]];then
	setStatus "cdt" "221" "4"
elif [[ $whatyouwannado == "retrieveblob" ]];then
	retrieveBlob 992 400 "/Users/lcle/tmp/excel5.csv" 
else
	echo "unknown error"
fi
