# Infromix enviroment for testing

#FROM docker.io/ibmcom/informix-developer-database:latest
FROM icr.io/informix/informix-developer-database:latest

#Capture the pods UID and GID
  RUN echo "export MYUID=$(id -u)" > /tmp/envfile; echo "export MYGID=$(id -g)" >> /tmp/envfile

  USER root
#Install deps tools
#  RUN mv /etc/yum.repos.d/centos.repo /etc/yum.repos.d/centos.repo.old
#  RUN microdnf install -y yum
#  RUN yum clean all; yum install -y net-tools gcc make

#Make Infomix a sudoer
  RUN . /tmp/envfile; sed -i "s/:200:200:/:${MYUID}:${MYGID}:/" /etc/passwd; sed -i "s/:200:/:${MYGID}:/" /etc/group
  RUN find /home /opt -uid 200 -exec chown informix.informix {} \;
  RUN echo 'informix ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
  RUN chmod -R a+rwX /home/informix /opt/ibm
  
#Install myexport
#  RUN cd /home/informix
#  RUN pwd
#  RUN mkdir /home/informix/myexport
#  RUN wget  ftp://ftp.iiug.org/pub/informix/pub/myexport.shar.gz -O /home/informix/myexport/myexport.shar.gz
#  RUN gunzip /home/informix/myexport/myexport.shar.gz
#  RUN  cd /home/informix/myexport && sh /home/informix/myexport/myexport.shar
#  RUN chown -R informix:informix  /home/informix/myexport
#  RUN chmod -R a+x /home/informix/myexport
#  RUN mv /home/informix/myexport/* /opt/IBM/informix/bin
#  RUN rmdir /home/informix/myexport

# Copy our scripts from this file system into /opt/ibm/config folder in container
  COPY --chmod=755 --chown=informix:informix 	./bfs_init_extspaces.sh	/opt/ibm/config/bfs_init_extspaces.sh
  COPY --chmod=755 --chown=informix:informix 	./bfs_start_log.sh 	/opt/ibm/config/bfs_start_log.sh
  COPY --chmod=750 --chown=root:root 		./bfs_removedata.sh	/opt/ibm/config/bfs_removedata.sh

  USER informix

#Now get myschema
#  RUN mkdir /home/informix/utils2
#  WORKDIR /home/informix/utils2
#  RUN wget ftp://ftp.iiug.org/pub/informix/pub/utils2_ak.gz
#  RUN gunzip utils2_ak.gz
#  RUN ls -ltr
#  RUN  echo n | sh utils2_ak
#  RUN ar -x myschema.source.ar


# start and Run informix
  # set environment variables
  ENV DB_LOCALE EN_US.UTF8
  ENV CLIENT_LOCALE EN_US.UTF8
  ENV INFORMIXDIR /opt/IBM/informix
  ENV LD_LIBRARY_PATH $INFORMIXDIR/lib:/lib64:/usr/lib64:$LD_LIBRARY_PATH
  ENV INFORMIXSERVER informixoltp_tcp
  ENV ONCONFIG onconfig.informixoltp_tcp
  ENV INFORMIXSQLHOSTS "/opt/IBM/informix/etc/sqlhosts.informixoltp_tcp"
  ENV JAVA_HOME /usr/share/java
  ENV ANT_HOME /usr/share/ant
  ENV PATH $INFORMIXDIR/bin:$JAVA_HOME/bin:$PATH:$HOME/bin:$ANT_HOME/bin
  # Add POST Init Env here instead of command line
  ENV LICENSE accept
  ENV SIZE small
  ENV RUN_FILE_POST_INIT bfs_init_extspaces.sh 
  # End Custom
  WORKDIR /home/informix

  # start informix, and KEEP PROCESS RUNNING
  CMD oninit -y && bash
