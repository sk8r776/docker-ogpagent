FROM ubuntu:16.04

MAINTAINER Sk8r776

RUN apt-get update
RUN apt-get install -y subversion screen rsync sudo libxml-parser-perl libarchive-extract-perl libarchive-zip-perl
RUN useradd ogp_agent -p password -m
RUN echo 'ogp_agent ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN svn co svn://svn.code.sf.net/p/hldstart/svn/trunk/agent/ /opt/agent
RUN bash /opt/agent/install.sh install ogp_agent password /opt/OGP/