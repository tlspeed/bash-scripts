#!/bin/bash
#source /home/bdealey/.bashrc
export ORACLE_HOME=/usr/lib/oracle/11.2/client64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib
export LIBOVERLAY_SCROLLBAR=0 
cd /home/bdealey/apps/pentaho/data-integration
#/home/bdealey/apps/pentaho/data-integration/spoon.sh
./spoon.sh
