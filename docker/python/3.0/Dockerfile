FROM ubuntu:latest
# Update
RUN apt-get update
# Install Curl + Git
RUN apt-get install -y curl
RUN apt-get install -y git-core
# bash
COPY bootstrap.sh ~/setupweb.sh
RUN echo 'source ~/setupweb.sh' >> ~/.bashrc
# Install python
RUN apt-get install python3
# PIP
RUN curl --silent https://bootstrap.pypa.io/get-pip.py | python3 -
