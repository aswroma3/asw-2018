#!/bin/bash

# Script per l'accesso ad un servizio rest 

REST_SERVICE_NAME=team
REST_SERVICE_URL=http://localhost:8080

echo Accessing service rest ${REST_SERVICE_NAME} at ${REST_SERVICE_URL}

# accede al servizio con XML 
echo 
echo "GET ${REST_SERVICE_URL}/${REST_SERVICE_NAME} AS XML"
echo $(curl -s -H "Accept:application/xml" --get "${REST_SERVICE_URL}/${REST_SERVICE_NAME}") 

