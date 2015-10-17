#!/usr/bin/bash

# Build image
docker $1 $2 $3 $4 $5 $6
# RUN
sh ~/.web/tubs/run.sh
