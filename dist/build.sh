#!/usr/bin/bash

# Build image
docker build -f $1 -t $2 .
# RUN
echo Running...
docker run -d -p $3 -t $4
exit 0
