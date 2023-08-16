#!/bin/bash
# BFS Script
export BFSCONFDIR=/opt/ibm/conf
export BFSDATADIR=/opt/ibm/data
export BFSSPACEDIR=${BFSDATADIR}/spaces

export  DS_BATSP=batdbs.000
export  DS_FMSSP=fmsdbs.000

export  NM_BATSP=batdbs
export  NM_FMSSP=fmsdbs

echo "BFS Post Init Script Start"
sleep 1
#Touch the new DB Space Files
touch  ${BFSSPACEDIR}/${DS_FMSSP}
chmod 660 ${BFSSPACEDIR}/${DS_FMSSP}

touch  ${BFSSPACEDIR}/${DS_BATSP}
chmod 660 ${BFSSPACEDIR}/${DS_BATSP}

#Init additional spaces into the DB
sleep 1
onspaces -c -d ${NM_FMSSP} -k 2 -p ${BFSSPACEDIR}/${DS_FMSSP} -o 0 -s 256000
onspaces -c -d ${NM_BATSP} -k 2 -p ${BFSSPACEDIR}/${DS_BATSP} -o 0 -s 6400000
sleep 1
# DO a Level 0 Archive
ontape -s -L 0
sleep 1
echo "BFS Post Init Script Stop"
