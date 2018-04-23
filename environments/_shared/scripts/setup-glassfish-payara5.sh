#!/bin/bash

source "/home/asw/_shared/scripts/common.sh"

# set up Payara Java EE constants 
PAYARA_FILE_NAME=payara-5.181
PAYARA_ARCHIVE=payara-5.181.zip
PAYARA_DEST_PATH=/opt
PAYARA_HOME=/opt/payara5
AS_HOME=/opt/payara5/glassfish
JAVADB_HOME=/opt/payara5/javadb

GF_HOST=10.11.1.111
GF_ADMIN_PORT=4848

# questo (copia link dal sito web) non funziona 
# GET_PAYARA_URL=https://info.payara.fish/cs/c/?cta_guid=de4a19f2-46e5-4f92-88ae-36300d4edcc2&placement_guid=6c4914a9-26de-4da5-b0fe-cd9f01ed1bea&portal_id=334594&redirect_url=APefjpFI2i962WSgdH4p25-n_fpJMiUNF-FPGyvwFg-aAAfruB6UByvnRZ3LwLqDuPDfa2gKO8VTWRwFnky6zTuVXcydDPH3OnqxQInFHXKQwzOyK-cFlG6iIJ_0GB9HJBOb6JJnbPo7PZ5PBCIJvow4Gj-YLln8odFX8LrQ8_mEODqa5T_G8EDAiO4F0_8X0qJx7QIx8jGqcsIEuYPkenZg6dT7eox7zjGFcMXM9l33CxAJt4k3YNGW9ehRF4nffp77lvP_Cen4&hsutk=71fb76a686e0ac1c1aba505ce8d07c24&canon=https%3A%2F%2Fwww.payara.fish%2Fdownloads&click=7c844821-d472-48b6-9201-5d11dc7ac776&__hstc=229474563.71fb76a686e0ac1c1aba505ce8d07c24.1520349234477.1523348750746.1523350800557.7&__hssc=229474563.2.1523350800557&__hsfp=1199701023
# questo link funziona (almeno per ora), ma non so se è un URL stabile
GET_PAYARA_URL=https://s3-eu-west-1.amazonaws.com/payara.fish/Payara+Downloads/5.181/payara-5.181.zip

GLASSFISH_ACC_FILE=glassfish-acc.xml

APPCLIENT_ARCHIVE=appclient-glassfish-payara5-10.11.1.111.jar
GLASSFISH_ACC_FILE_COPY=glassfish-payara5-acc.xml

function installLocalGlassfishPayara {
	echo "============================="
	echo "installing glassfish (payara)"
	echo "============================="
	FILE=${ASW_DOWNLOADS}/${PAYARA_ARCHIVE}
	unzip -q $FILE -d ${PAYARA_DEST_PATH}
}

function installRemoteGlassfishPayara {
	echo "=============================="
	echo "downloading glassfish (payara)"
	echo "=============================="
	# NON FUNZIONA 
	wget -q -P ${ASW_DOWNLOADS} ${GET_PAYARA_URL}
	installLocalGlassfishPayara 
}

function setupEnvVars {
	echo "creating glassfish (payara) environment variables"
	echo export PAYARA_HOME=${PAYARA_HOME} >> /etc/profile.d/glassfish-payara.sh
	echo export AS_HOME=${AS_HOME} >> /etc/profile.d/glassfish-payara.sh
	echo export JAVADB_HOME=${JAVADB_HOME} >> /etc/profile.d/glassfish-payara.sh
	echo export PATH=\${PATH}:\${AS_HOME}/bin:\${PAYARA_HOME}/bin:\${JAVADB_HOME}/bin >> /etc/profile.d/glassfish-payara.sh
	# per semplificare gli script di deployment 
	echo export GF_HOST=${GF_HOST} >> /etc/profile.d/glassfish-payara.sh
	echo export GF_ADMIN_PORT=${GF_ADMIN_PORT} >> /etc/profile.d/glassfish-payara.sh
}

function createModifiedAccFile {
	INFILE=$1 
	OUTFILE=$2 
	# Legge il file $INFILE e lo copia in $OUTFILE, ma sostituisce 
	# - <target-server name="OpenSUSE-Leap-Headless.suse" address="localhost" port="3700"/>
	# con 
	# - <target-server name="payara" address="10.11.1.111" port="3700"/>
	sed -r 's#(<target-server name)="OpenSUSE-Leap-Headless.suse" address="localhost" (port="3700"/>)#\1="payara" address="10.11.1.111" port="3700"/>#' $INFILE > $OUTFILE
}

function setupGlassfishAccFile {
	echo "modifying ${GLASSFISH_ACC_FILE} file"
	FILE=${AS_HOME}/domains/domain1/config/${GLASSFISH_ACC_FILE}
	createModifiedAccFile ${FILE} ${FILE}.new 
	mv ${FILE} ${FILE}.bak
	mv ${FILE}.new ${FILE}
	cp ${FILE} ${ASW_DOWNLOADS}/${GLASSFISH_ACC_FILE_COPY}
}

function setupGlassfishPayara {
	echo "configuring glassfish (payara)"
	
	# aggiorna il file di configurazione dell'appclient
	setupGlassfishAccFile
	
	echo "setting up payara service"
	# definisce java ee come servizio 
	${AS_HOME}/bin/asadmin create-service 
	
	# il servizio può essere avviato come segue ... ma lo facciamo in modo diverso 
	# echo "starting glassfish service"
	# /etc/init.d/GlassFish_domain1 start

	# avvio del dominio 
	echo "starting payara domain"
	${AS_HOME}/bin/asadmin start-domain

	# volendo, la configurazione di glassfish si può esaminare così 
	# ${AS_HOME}/bin/asadmin get "*"  

	# volendo, il server HTTP può essere esposto sulla porta 80 anziché 8080
	# ${AS_HOME}/bin/asadmin set configs.config.server-config.network-config.network-listeners.network-listener.http-listener-1.port=80 

	# ulteriori configurazioni per JMS (non tutte sono ideali, perché il dominio sia chiama "localhost..." ma non è su localhost 
	# in effetti sembrano necessarie solo le ultime due (e per questo le altre sono state commentate) 
	# ${AS_HOME}/bin/asadmin set nodes.node.localhost-domain1.name=server-domain1 
	# ${AS_HOME}/bin/asadmin set nodes.node.localhost-domain1.node-host=10.11.1.101 
	${AS_HOME}/bin/asadmin set configs.config.default-config.jms-service.jms-host.default_JMS_host.host=10.11.1.111 
	${AS_HOME}/bin/asadmin set configs.config.server-config.jms-service.jms-host.default_JMS_host.host=10.11.1.111 

	echo "configuring payara appclient"
	${AS_HOME}/bin/package-appclient 
	cp ${AS_HOME}/lib/appclient.jar ${ASW_DOWNLOADS}/${APPCLIENT_ARCHIVE}
}

function installGlassfishPayara {
	if downloadExists ${PAYARA_ARCHIVE}; then
		installLocalGlassfishPayara
	else
		installRemoteGlassfishPayara
	fi
}

function installPrerequisites {
	echo "installing unzip"
	apt-get install unzip 
}

echo "setup javaee (glassfish payara)"
installPrerequisites
installGlassfishPayara
setupEnvVars
setupGlassfishPayara
