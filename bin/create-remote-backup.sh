#!/bin/bash

###
### This script will remotely backup a file to the remote backup server(s)
### Inputs 
###   1) Full Path to file to be backed up
###   2) Directory to store file at remotebackup site
###   3) FDT02 Directory to store file at remotebackup site

BACKUPFILENAME=$1
REMOTEDIR=$2
FDT02_REMOTEDIR=$3


## Step1: Create a backup on another FDT server
#scp  -q -B -p -i /root/.ssh/remotebackup_id_rsa ${BACKUPFILENAME} remotebackup@192.168.10.51:${REMOTEDIR}

## NEW backup server to FDT02
scp  -q -B -p -i /root/.ssh/remotebackup_id_rsa ${BACKUPFILENAME} remotebackup@backup02:${FDT02_REMOTEDIR}

## Step2: Create an offsite copy of this backup
#scp  -q -B -p -i /root/.ssh/remotebackup_id_rsa -P224 ${BACKUPFILENAME} remotebackup@dealey.com:${REMOTEDIR}


