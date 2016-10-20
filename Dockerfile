FROM ubuntu:16.04

MAINTAINER joshhsoj1902 

RUN apt-get update
RUN apt-get install -y subversion screen rsync sudo libxml-parser-perl libarchive-extract-perl libarchive-zip-perl libpath-class-perl wget curl unzip lib32gcc1 perl-modules pure-ftpd e2fsprogs libhttp-daemon-perl libarchive-any-perl libio-compress-perl pure-ftpd e2fsprogs 

ADD ogpmanager.sh /usr/local/bin/
RUN mv /usr/local/bin/ogpmanager.sh /usr/local/bin/ogpmanager \
    && chmod +x /usr/local/bin/ogpmanager

RUN useradd ogp_agent -p password -m \
    && echo 'ogp_agent ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN svn co svn://svn.code.sf.net/p/hldstart/svn/trunk/agent/ /opt/agent 

RUN cd /opt/agent \
    && bash install.sh install ogp_agent password /opt/OGP/

COPY Cfg /opt/OGP/Cfg

EXPOSE 12679/tcp
EXPOSE 27015/udp 7778/udp
EXPOSE 32330/tcp

CMD ["ogpmanager"]
