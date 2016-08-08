FROM ubuntu:16.04

MAINTAINER Sk8r776

RUN apt-get update
RUN apt-get install -y subversion screen rsync sudo libxml-parser-perl libarchive-extract-perl libarchive-zip-perl libpath-class-perl wget curl unzip
RUN wget https://raw.githubusercontent.com/sk8r776/docker-ogpagent/master/ogpmanager.sh -O /tmp/ogpmanager.sh \
	&& mv /tmp/ogpmanager.sh /usr/local/bin/ogpmanager \
	&& chmod +x /usr/local/bin/ogpmanager

EXPOSE 12679/tcp
EXPOSE 27015/udp 7778/udp
EXPOSE 32330/tcp

CMD ["ogpmanager"]