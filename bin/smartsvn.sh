#!/bin/bash
#
# Normally, editing this script should not be required.
#
# To specify an alternative Java Runtime Environment, uncomment the following line and edit the path
#SMARTSVN_JAVA_HOME=/usr/lib/java

# Set the maximum heap size
MAXIMUM_HEAP_SIZE=256m

# If you experience problems, e.g. incorrectly painted windows, try to uncomment one of the following two lines
#export AWT_TOOLKIT=MToolkit
#export AWT_TOOLKIT=XToolkit

if [ "$SMARTSVN_JAVA_HOME" = "" ] ; then
    SMARTSVN_JAVA_HOME=$JAVA_HOME
fi

_JAVA_EXEC="java"
if [ "$SMARTSVN_JAVA_HOME" != "" ] ; then
    _TMP="$SMARTSVN_JAVA_HOME/bin/java"
    if [ -f "$_TMP" ] ; then
        if [ -x "$_TMP" ] ; then
            _JAVA_EXEC="$_TMP"
        else
            echo "Warning: $_TMP is not executable"
        fi
    else
        echo "Warning: $_TMP does not exist"
    fi
fi

if ! which "$_JAVA_EXEC" >/dev/null ; then
    echo "Error: No java environment found"
    exit 1
fi

#
# Resolve the location of the SmartSVN installation.
# This includes resolving any symlinks.
PRG=$0
while [ -h "$PRG" ]; do
    ls=`ls -ld "$PRG"`
    link=`expr "$ls" : '^.*-> \(.*\)$' 2>/dev/null`
    if expr "$link" : '^/' 2> /dev/null >/dev/null; then
        PRG="$link"
    else
        PRG="`dirname "$PRG"`/$link"
    fi
done

SMARTSVN_BIN=`dirname "$PRG"`

# absolutize dir
oldpwd=`pwd`
cd "${SMARTSVN_BIN}"; SMARTSVN_BIN=`pwd`
cd "${oldpwd}"; unset oldpwd

#SMARTSVN_HOME=`dirname "$SMARTSVN_BIN"`
SMARTSVN_HOME=/home/bdealey/apps/smartsvn


_VM_PROPERTIES="-Dsun.io.useCanonCaches=false -Djava.net.preferIPv4Stack=true"

# -XX:-UseSSE42Intrinsics is used to work-around bug 6875866 of Java 1.6.0_20 (and earlier) on Intel Nehalem CPUs, e.g. Core i7
$_JAVA_EXEC -XX:-UseSSE42Intrinsics -version >/dev/null 2>/dev/null
if [ $? = 0 ] ; then
  echo "Disabling SSE42Intrinsics to work around bug 6875866."
  _VM_PROPERTIES="-XX:-UseSSE42Intrinsics $_VM_PROPERTIES"	
fi


#
# Where settings are stored?
#
# SmartSVN stores it's setting per default in '$HOME/.smartsvn' . If you want
# to change this (e.g. to install different SmartSVN versions on the same
# machine and under the same user account), you need to set the Java system
# property 'smartsvn.home'. You could use other system properties by
# surrounding them with '${<system-property>}'.
#
# Example:
# To tell SmartSVN to store its settings in '$HOME/.smartsvn-settings',
# you can use the property 'user.home', which represents the user's home
# directory.
# The following line will do the job (if uncommented):
#_VM_PROPERTIES="$_VM_PROPERTIES -Dsmartsvn.home=\${user.home}/.smartsvn-settings"
#
# To make SmartSVN a portable application you may store the settings directly
# within the installation directory. For this purpose you can use the
# system property 'smartsvn.installation' here, which refers to the
# installation root of SmartSVN.
# The following line will do the job (if uncommented):
#_VM_PROPERTIES="$_VM_PROPERTIES -Dsmartsvn.home=\${smartsvn.installation}/.smartsvn"

$_JAVA_EXEC $_VM_PROPERTIES -Xmx${MAXIMUM_HEAP_SIZE} -Dsmartsvn.vm-xmx=${MAXIMUM_HEAP_SIZE} -jar "$SMARTSVN_HOME/lib/smartsvn.jar" "$@"
