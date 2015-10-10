#!/usr/bin/bash
echo Preparing to run web-app...
echo Updating nodejs...
nvm install stable
echo Installing ruby...
sudo apt-get install ruby-full
echo Installing bundle...
gem install bundle
cd ./app