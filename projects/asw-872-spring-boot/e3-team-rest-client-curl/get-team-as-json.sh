#!/bin/bash

# Script per l'accesso ad un servizio rest 

REST_SERVICE_NAME=team
REST_SERVICE_URL=http://localhost:8080

echo Accessing service rest ${REST_SERVICE_NAME} at ${REST_SERVICE_URL}

# accede al servizio con JSON 
echo 
echo "GET ${REST_SERVICE_URL}/${REST_SERVICE_NAME} AS JSON"
echo $(curl -s -H "Accept:application/json" --get "${REST_SERVICE_URL}/${REST_SERVICE_NAME}") 
