#!/usr/bin/bash

# Build image
docker build -f $1 -t $2 .
# RUN
echo Running...
docker run -p $3 -d $4
exit 0
