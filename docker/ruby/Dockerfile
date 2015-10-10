FROM ubuntu:latest
# Update
RUN apt-get update
# Install Curl + Git
RUN apt-get install -y curl
RUN apt-get install -y git-core
# Install ruby
RUN apt-get install -y ruby-full --fix-missing
# bundle
RUN gem install bundle
# Done!
