FROM ubuntu:16.04

MAINTAINER joshhsoj1902

RUN apt-get update \
 && apt-get install -y  subversion \
                        build-essential \
                        screen \
                        rsync \
                        sudo \
                        libxml-parser-perl \
                        libarchive-extract-perl \
                        libarchive-zip-perl \
                        libpath-class-perl \
                        wget \
                        curl \
                        unzip \
                        lib32gcc1 \
                        lib32stdc++6 \
                        perl-modules \
                        pure-ftpd \
                        e2fsprogs \
                        libhttp-daemon-perl \
                        libarchive-any-perl \
                        libio-compress-perl \
                        libfrontier-rpc-perl \
                        pure-ftpd \
                        e2fsprogs

RUN cpan Frontier::Daemon::Forking Crypt::XXTEA

ADD ogpmanager.sh /usr/local/bin/
RUN mv /usr/local/bin/ogpmanager.sh /usr/local/bin/ogpmanager \
    && chmod +x /usr/local/bin/ogpmanager

RUN useradd ogp_agent -p password -m \
    && echo 'ogp_agent ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN wget -P ~ https://github.com/OpenGamePanel/OGP-Agent-Linux/archive/2b7e3b729985978a0b268f517652cae579639411.zip \
  && unzip ~/2b7e3b729985978a0b268f517652cae579639411.zip -d ~/ \
  && cp -rp ~/OGP-Agent-Linux-2b7e3b729985978a0b268f517652cae579639411 /opt/agent

RUN cd /opt/agent \
  && bash /opt/agent/install.sh install ogp_agent password /opt/OGP/

COPY ogp_agent/Cfg /opt/OGP/Cfg

# forward logs to docker log collector
RUN ln -sf /dev/stdout /opt/OGP/ogp_agent.log

EXPOSE 12679/tcp
EXPOSE 27015/udp 27015/udp

CMD ["ogpmanager"]
