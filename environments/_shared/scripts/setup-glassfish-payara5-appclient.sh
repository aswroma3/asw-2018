#!/bin/bash

source "/home/asw/_shared/scripts/common.sh"

# set up Payara Java EE constants 
APPCLIENT_ARCHIVE=appclient-glassfish-payara5-10.11.1.111.jar
EXTRACT_PATH=/opt
APPCLIENT_PATH=/opt/appclient

function installLocalPayaraAppclient {
	echo "==========================="
	echo "installing payara appclient"
	echo "==========================="
	FILE=${ASW_DOWNLOADS}/${APPCLIENT_ARCHIVE}
	cd ${EXTRACT_PATH}
	jar -xf $FILE 
	chmod a+x ${APPCLIENT_PATH}/glassfish/bin/appclient 
}

function setupEnvVars {
	echo "creating payara appclient environment variables"
	echo export APPCLIENT_HOME=${APPCLIENT_PATH} >> /etc/profile.d/javaee-appclient.sh
	echo export PATH=\${PATH}:\${APPCLIENT_HOME}/glassfish/bin >> /etc/profile.d/javaee-appclient.sh
}

function setupPayaraAppclient {
	echo "setting up payara appclient"
	# niente da fare 
}

function installPayaraAppclient {
	if downloadExists $APPCLIENT_ARCHIVE; then
		installLocalPayaraAppclient
	else
		echo "missing resource: " ${ASW_DOWNLOADS}/$APPCLIENT_ARCHIVE
	fi
}

echo "setup payara appclient"
installPayaraAppclient
setupEnvVars
setupPayaraAppclient
