#!/bin/bash

## Script parameters
if [ $# -ne 1 ];
then
   echo "usage: $0 <schema name>"
   exit
fi
SCHEMA_NAME=$1

DEBUG=true
EXECUTE=true
LOG=/u02/oracle/exports/export_schema.log

##################################################
#######  STEP1: Perform Export via dataPump ######
##################################################
echo "$0 STEP1: Begin: ${SCHEMA_NAME}" >> ${LOG}

## Oracle sqlplus login parameters
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/dbhome_1
#export ORACLE_HOME=/u01/app/oracle/product/10.2.0/db_1
ORA_PARMS=NXDBBackupAdmin/fdtBckMEupAdm1n@nxdb2

EXP_date=`date '+%Y%m%d%H%M'`
EXP_schema=${SCHEMA_NAME}
BaseFileName=${EXP_date}_nxdb-schema-${SCHEMA_NAME}
EXP_dumpFileName=${BaseFileName}.dmp
EXP_logFileName=${BaseFileName}.log
ORA_directory=U02_ORACLE_EXPORTS_NXDB04
OS_directory=/u02/oracle/exports

${ORACLE_HOME}/bin/expdp ${ORA_PARMS} schemas=${SCHEMA_NAME} directory=${ORA_directory} dumpfile=${EXP_dumpFileName} logfile=${EXP_logFileName}


##################################################
#######  STEP2: Compress dump/log file      ######
##################################################
echo "$0 STEP2: Begin: ${SCHEMA_NAME}" >> ${LOG}

TARC="tar --directory ${OS_directory} --remove-file -czf"
zipfilename=${BaseFileName}.tgz

${TARC} ${OS_directory}/${zipfilename} ${EXP_logFileName} ${EXP_dumpFileName} 


##################################################
#######  STEP3: Backup log file to admin02  ######
##################################################
echo "$0 STEP3: Begin: ${SCHEMA_NAME}" >> ${LOG}

SCP=/usr/bin/scp
SSH=/usr/bin/ssh
SSHKEY="-i /home/oracle/.ssh/remotebackup_id_rsa"
BACKUPUSER=remotebackup
BACKUPHOST=admin02.ntelx.net
BACKUPHOST_DIR=/fdt/backup/nxdb/exports

${SCP} ${SSHKEY} ${OS_directory}/${zipfilename} ${BACKUPUSER}@${BACKUPHOST}:${BACKUPHOST_DIR}

echo "$0 Done: ${SCHEMA_NAME}" >> ${LOG}
