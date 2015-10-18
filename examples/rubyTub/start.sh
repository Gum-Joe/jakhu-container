#!/usr/bin/bash
echo Starting Web-app...
cd /container
sh ./versions.sh
. ./env.sh
cd app
export PORT=8080
bin/rails server