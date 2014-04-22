# This is the init script for starting up the
#  Jakarta Tomcat server
#
# chkconfig: 345 91 10
# description: Starts and stops the Tomcat daemon.
#

# Source function library.
. /etc/rc.d/init.d/functions

# Get config.
. /etc/sysconfig/network

# Check that networking is up.
[ "${NETWORKING}" = "no" ] && exit 0

tomcat=/home/alfres/Alfresco/tomcat
startup=$tomcat/bin/startup.sh
shutdown=$tomcat/bin/shutdown.sh
export JAVA_HOME=/usr/java/default

start(){
 echo -n $"Starting Tomcat service: "
 #daemon -c
 $startup
 RETVAL=$?
 echo
}

stop(){
 action $"Stopping Tomcat service: " $shutdown 
 RETVAL=$?
 echo
}

restart(){
  stop
  start
}


# See how we were called.
case "$1" in
start)
 start
 ;;
stop)
 stop
 ;;
status)
      # This doesn't work ;)
 status tomcat
 ;;
restart)
 restart
 ;;
*)
 echo $"Usage: $0 {start|stop|status|restart}"
 exit 1
esac

exit 0
