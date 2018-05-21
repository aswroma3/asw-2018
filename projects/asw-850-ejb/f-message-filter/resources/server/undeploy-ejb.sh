#!/bin/bash

# Script per la rimozione dell'EJB 

echo Undeploying message-filter EJB 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

EJB_JAR=message-filter-ejb.jar 
EJB_NAME=MessageFilter 
ASW_JMS_JAR=asw-jms.jar 
ASW_UTIL_JAR=asw-util.jar 

${ASADMIN} undeploy ${EJB_NAME} 
${ASADMIN} remove-library --type app ${ASW_JMS_JAR}
${ASADMIN} remove-library --type app ${ASW_UTIL_JAR}



