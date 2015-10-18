# Examples
These are examples of configs and tubs.
The config files are what would be inside of your .web.yml.

Tubs are made up of:
 * `env.sh` - includes enviroment varibles. Sourced by all scripts
 * `start.sh` - start the web app.
 * `build.sh` - builds the web-app and is ran when the docker image is set-up
 * `Dockerfile` - for building the image
 * `.web.yml` - the config used
 * `versions.sh` - outputs version numbers. used by start.sh
