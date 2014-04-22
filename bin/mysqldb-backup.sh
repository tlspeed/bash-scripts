#!/bin/bash

## The mysqld database name must be passed into this script
DBNAME=$1

if [ -z "${DBNAME}" ]; then
   echo "ERROR: Missing required parameter DBNAME"
   exit
fi 


#Create the temporary dump location
TMPDIR=/tmp/mysqlhotcopy

REMOTEDIR=/usr3/remotebackup/mysql
BACKUP02_REMOTEDIR=/fdt/backup/mysql

## Create the TMPDIR if it doesn't exist
if  [ ! -d ${TMPDIR} ]; then  mkdir ${TMPDIR}; fi;

## Backup the MySQL database for the given database
/usr/bin/mysqlhotcopy -u root -p fdtmYSQLr00t --allowold ${DBNAME} ${TMPDIR}

## Zip up these files and save for later
backupFile=/opt/backup/mysql/`/bin/date +%Y%m%d_%H%M`_mysqldb_app01_${DBNAME}.gz
tar cvfz ${backupFile} ${TMPDIR}/${DBNAME}

/usr/local/bin/create-remote-backup.sh ${backupFile} ${REMOTEDIR} ${BACKUP02_REMOTEDIR}
