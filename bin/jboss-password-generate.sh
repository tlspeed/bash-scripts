#!/bin/bash
#### Generate a JBOSS password
JBOSS_HOME=~/fdt/projects/spirit/FD-jboss423.oracle

java -cp ${JBOSS_HOME}/lib/jboss-jmx.jar:${JBOSS_HOME}/lib/jboss-common.jar:${JBOSS_HOME}/server/default/lib/jboss-jca.jar:${JBOSS_HOME}/server/default/lib/jbosssx.jar org.jboss.resource.security.SecureIdentityLoginModule $1
