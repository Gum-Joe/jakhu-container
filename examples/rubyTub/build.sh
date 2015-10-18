#!/usr/bin/bash
echo Preparing to run web-app...
echo . /container/env.sh
. /container/env.sh
echo Updating ruby...
echo rvm install ruby-head
rvm install ruby-head
echo rvm use latest
rvm use latest
echo ruby --version
ruby --version
echo Installing bundle...
echo gem install bundle
gem install bundle
echo Installing java7...
echo apt-get install -y openjdk-7-jre openjdk-7-jdk maven ant
apt-get install -y openjdk-7-jre openjdk-7-jdk maven ant
echo Installing nodejs...
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash
. ~/.nvm/nvm.sh
nvm install stable
echo Installing python...
echo apt-get install -y python3
apt-get install -y python3

cd ./app
echo Installing dependencies...
echo bundle install
bundle install
echo Building...
echo rake
rake
