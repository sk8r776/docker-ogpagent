FROM ubuntu:16.04

MAINTAINER Sk8r776

RUN apt-get update
RUN apt-get install -y subversion

RUN svn co svn://svn.code.sf.net/p/hldstart/svn/trunk/agent/ agent