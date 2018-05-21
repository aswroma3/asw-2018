#!/bin/bash

# Script per la rimozione delle risorse JMS per le applicazioni asw850 

# GF_HOST e GF_ADMIN_PORT settate in /etc/profile.d/glassfish-***.sh
ASADMIN="asadmin --echo=true --host ${GF_HOST} --port ${GF_ADMIN_PORT}"

QUEUE_ONE_NAME=jms/asw/ejb/QueueOne
QUEUE_TWO_NAME=jms/asw/ejb/QueueTwo
CFNAME=jms/asw/ConnectionFactory

echo Deleting JMS resources for asw850

${ASADMIN} delete-jms-resource ${QUEUE_ONE_NAME} 

${ASADMIN} delete-jms-resource ${QUEUE_TWO_NAME} 

${ASADMIN} delete-jms-resource ${CFNAME} 

echo JMS resources for asw850 deleted
