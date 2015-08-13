# My pipeline 2015 Tandem replication
# base image
FROM ubuntu:14.04

# Maintainer 
MAINTAINER  Maurizio Polano "mauriziopolano@blu.it"

# update system
RUN apt-get update &&  apt-get upgrade -y && apt-get dist-upgrade -y 

RUN  apt-get install wget -y
#--------------pear preparation ----------------------------------------------------------------------------------------------#


RUN cd /opt && \
    wget -c -P /opt/pear http://sco.h-its.org/exelixis/web/software/pear/files/pear-0.9.6-bin-64.tar.gz && \
    tar -xzf /opt/pear/pear-0.9.6-bin-64.tar.gz -C /opt/pear/  
RUN add-apt-repository ppa:git-core/ppa

RUN apt-get update && apt-get -y -f upgrade 
RUN apt-get install -y build-essential
RUN apt-get update && apt-get install -y git
RUN apt-get install -y python

RUN cd /opt/ && git clone https://github.com/mafouille/doMreps
#---------------------------------------------------------------------


# Use baseimage-docker's bash.
CMD ["/bin/bash"]
RUN  apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get autoclean && \
    apt-get autoremove -y && \
   rm -rf /var/lib/{apt,dpkg,cache,log}/
    
#Add star to PATH
ENV PATH /opt/pear/pear-0.9.6-bin-64/:$PATH
ENV PATH /opt/doMreps/:$PATH
