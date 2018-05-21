#!/bin/bash

# Script per la creazione delle risorse JMS per le applicazioni asw850 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

QUEUE_ONE_NAME=jms/asw/ejb/QueueOne
QUEUE_TWO_NAME=jms/asw/ejb/QueueTwo
CFNAME=jms/asw/ConnectionFactory

echo Creating JMS resources for asw850

${ASADMIN} create-jms-resource --restype javax.jms.Queue --enabled=true ${QUEUE_ONE_NAME} 

${ASADMIN} create-jms-resource --restype javax.jms.Queue --enabled=true ${QUEUE_TWO_NAME} 

${ASADMIN} create-jms-resource --restype javax.jms.ConnectionFactory --enabled=true ${CFNAME} 

echo JMS resources for asw850 created
