FROM ubuntu:16.04

MAINTAINER Sk8r776

RUN apt-get update
RUN apt-get install -y subversion screen rsync sudo libxml-parser-perl libarchive-extract-perl libarchive-zip-perl
RUN useradd ogp_agent -p password -m
RUN echo 'ogp_agent ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN svn co svn://svn.code.sf.net/p/hldstart/svn/trunk/agent/ /opt/agent
RUN wget https://raw.githubusercontent.com/sk8r776/docker-ogpagent/master/InstallWrapper.sh -O /opt/agent/InstallWrapper.sh \
	&& chmod +x /opt/agent/InstallWrapper.sh \
	&& /opt/agent/InstallWrapper.sh

EXPOSE 12679/tcp
EXPOSE 27015/udp 7778/udp
EXPOSE 32330/tcp

#RUN su - ogp_agent -c "/opt/ogp_agent.pl"