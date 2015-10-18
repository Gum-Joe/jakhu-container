FROM ubuntu:latest
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get install -y git-core
RUN echo Installing prerequisites...
RUN apt-get install -y gnupg
RUN echo Installing ruby...
RUN apt-get install -y ruby
RUN echo Installing rails and bundle...
RUN gem install bundle rails
COPY .tubs/tub9406244859565052 /container
COPY instances/rubyapp /container/app
EXPOSE 8080
CMD cd /container && sh ./start.sh