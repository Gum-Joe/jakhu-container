FROM ubuntu:latest
RUN apt-get install -y curl
RUN apt-get install -y git-core
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash

COPY .tubs/tub6808431202080102 /container
COPY instances/nodejs /container/app
RUN cd /container; sh ./build.sh
EXPOSE 8080
CMD cd /container && sh ./start.sh