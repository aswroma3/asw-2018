#!/bin/bash

# Script per la rimozione del web service REST

echo Undeploying Async rest service 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

REST_CONTEXT_ROOT=asw/asyncrest
# REST_APPLICATION=async 
REST_SERVICE=async 
REST_SERVICE_WAR=${REST_SERVICE}.war 
REST_SERVICE_NAME=AsyncRest

ASW_UTIL_JAR=asw-util.jar 

${ASADMIN} undeploy ${REST_SERVICE_NAME} 

${ASADMIN} remove-library --type app ${ASW_UTIL_JAR}




