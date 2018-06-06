#!/bin/bash

# Script per la rimozione del web service REST

echo Undeploying hello rest service 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

REST_CONTEXT_ROOT=asw/hellorest
# REST_APPLICATION=hello 
REST_SERVICE=hello 
REST_SERVICE_WAR=${REST_SERVICE}.war 
REST_SERVICE_NAME=HelloRest

${ASADMIN} undeploy ${REST_SERVICE_NAME} 



