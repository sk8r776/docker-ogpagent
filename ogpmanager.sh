#!/bin/bash
if [ -f /opt/agent/ogp_agent_run ]; then
	su ogp_agent -c /opt/OGP/ogp_agent_run
else
	useradd ogp_agent -p password -m
	echo 'ogp_agent ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
	svn co svn://svn.code.sf.net/p/hldstart/svn/trunk/agent/ /opt/agent
	cd /opt/agent
	bash install.sh install ogp_agent password /opt/OGP/
	wget --no-check-certificate https://pfsense/hold/docker/ogpagents/ogpagent1/Config.pm -O /opt/OGP/Cfg/Config.pm
	wget --no-check-certificate https://pfsense/hold/docker/ogpagents/ogpagent1/Preferences.pm -O /opt/OGP/Cfg/Preferences.pm
	wget --no-check-certificate https://pfsense/hold/docker/ogpagents/ogpagent1/bash_prefs.cfg -O /opt/OGP/Cfg/bash_prefs.cfg
	cd /
	su ogp_agent -c /opt/OGP/ogp_agent_run
fi