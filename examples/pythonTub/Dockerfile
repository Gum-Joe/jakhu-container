FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y git-core
COPY .tubs/tub2430098119657487 /container
COPY instances/python /container/app
RUN cd /container; sh build.sh
EXPOSE 8080
CMD cd /container && sh ./start.sh