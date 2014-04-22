#!/bin/bash


###
### Parms
###  DumpFileName 1st file

if [ $# -lt 1 ] || [ $# -gt 2 ];
then
   echo "usage: $0 DumpFileFirstFileName ImpOptions"
   exit
fi

BASEFILE=$1
OPTIONS="METRICS=Y PARRALLEL=4 $2"

## ORACLE_DIR is the oracle name of the physical path
##  These two need to point to same place (but can have different names)
ORACLE_DIR=U02_ORACLE_IMPORTS
ROOT_DIR=/u02/oracle/imports

## For oracle exports, we always start with filenum 01
filenum=1
filenumFormatted=$(printf "%02d" $filenum)


fileName=$BASEFILE
fileNameStr=

## Look for filesnames of the basename YYYYMMDD-xxxxxx01.dmp 
## and generate sequential filenames until we come to one that doesn't exist
loop=1
while [ $loop -eq 1 ]; 
do

	if [ ! -e $ROOT_DIR/$fileName ];
	then
		loop=0;
		break;
	fi

	oldfilenumFormatted=$filenumFormatted
	filenum=$(($filenum+1))
	filenumFormatted=$(printf "%02d" $filenum)
	 
	newfileName=$(echo $fileName | sed -e "s/${oldfilenumFormatted}.dmp/${filenumFormatted}.dmp/" )

	if [ "${fileNameStr}X" = "X" ]; then
	    fileNameStr="$fileName"
	else
    
	    fileNameStr="$fileNameStr,$fileName"
	fi

	fileName=$newfileName
done


LOGFILE=${BASEFILE%.*}.log

CMD_BASE="time impdp bdealey directory=U02_ORACLE_IMPORTS logfile=$LOGFILE dumpfile=${fileNameStr} ${OPTIONS}" 


echo 
echo $CMD_BASE
echo
