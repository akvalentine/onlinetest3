#!/bin/bash
# BFS Script
#export BFSCONFDIR=/opt/IBM/informix/data/config1
#export BFSDATADIR=/opt/IBM/informix/data/dbdata1
export BFSCONFDIR=/opt/ibm/config
export BFSDATADIR=/opt/ibm/data
export BFSSPACEDIR=${BFSDATADIR}/spaces

export  C_SQLHOSTS=sqlhosts
export  C_CREDS=wl_credentials_status_file
export  C_ONCON=onconfig
export  C_MONGO=wl_mongo.properties
export  C_REST=wl_rest.properties
export  C_MQTT=wl_mqtt.properties


export  D_INIT=.initialized
export  D_INITSTAT=init_status.log
export  DS_BATSP=batdbs.000
export  DS_FMSSP=fmsdbs.000
export  DS_ROOTSP=rootdbs.000


# This is a pre init script
# init only runs when new DB setup is required
# need to clean up files from old DB before init
# Cleanup of previous files CONFIG FILES FIRST
echo "BFS Remove existing Database Script Started"

echo "**WARNING***WARNING***WARNING***"
echo "The existing database and associated files"
echo "Will be removed with this Script"
echo "A new clean DB will be initialized on Container restart"
echo "This Cannot be unDone"
echo "Press  Ctrl-C now to abort"
sleep 10
echo "**WARNING***WARNING***WARNING***"
echo "You have 3 Seconds to abort script"
sleep 3
echo "**WARNING***WARNING***WARNING***"
echo "Script is Starting now!!!"
sleep 2
exit

if [ -f  ${BFSCONFDIR}/${C_SQLHOSTS} ] 
then
	rm  -f  ${BFSCONFDIR}/${C_SQLHOSTS}
fi

if [ -f  ${BFSCONFDIR}/${C_CREDS} ] 
then
	rm  -f  ${BFSCONFDIR}/${C_CREDS}
fi

if [ -f  ${BFSCONFDIR}/${C_ONCON} ] 
then
	rm  -f  ${BFSCONFDIR}/${C_ONCON}
fi

if [ -f  ${BFSCONFDIR}/${C_MONGO} ] 
then
	rm  -f  ${BFSCONFDIR}/${C_MONGO}
fi

if [ -f  ${BFSCONFDIR}/${C_REST} ] 
then
	rm  -f  ${BFSCONFDIR}/${C_REST}
fi

if [ -f  ${BFSCONFDIR}/${C_MQTT} ] 
then
	rm  -f  ${BFSCONFDIR}/${C_MQTT}
fi

# Cleanup of previous files DATA FILES NEXT

if [ -f  ${BFSDATADIR}/${D_INIT} ] 
then
	rm  -f  ${BFSDATADIR}/${D_INIT}
fi

if [ -f  ${BFSDATADIR}/${D_INITSTAT} ] 
then
	rm  -f  ${BFSDATADIR}/${D_INITSTAT}
fi

# Cleanup of previous files DATA SPACES LAST


if [ -f  ${BFSSPACEDIR}/${DS_BATSP} ] 
then
	rm  -f  ${BFSSPACEDIR}/${DS_BATSP}
fi

if [ -f  ${BFSSPACEDIR}/${DS_FMSSP} ] 
then
	rm  -f  ${BFSSPACEDIR}/${DS_FMSSP}
fi

if [ -f  ${BFSSPACEDIR}/${DS_ROOTSP} ] 
then
	rm  -f  ${BFSSPACEDIR}/${DS_ROOTSP}
fi

sleep 1

#touch  ${BFSSPACEDIR}/${DS_ROOTSP}
#chmod 660 ${BFSSPACEDIR}/${DS_ROOTSP}

sleep 2

echo "BFS Pre Init Script completed"
