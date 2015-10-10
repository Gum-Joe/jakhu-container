FROM ubuntu:latest
# Update
RUN apt-get update
#Install curl and git
RUN apt-get install -y curl git-core
# Install Node.js and npm
RUN curl --silent --location https://deb.nodesource.com/setup_0.12 | sudo bash -
RUN apt-get install -y nodejs
# Install nvm
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
# Update nodejs
RUN nvm install stable
# Done!
