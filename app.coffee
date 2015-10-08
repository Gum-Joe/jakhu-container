# Parse YAML to get config
parse = require './libs/yaml.js'
fs = require 'fs'
path = require 'path'
get = require './libs/get.js'
checks = require './libs/checks.js'
# Read instances

exports.start = (args, dir) ->
  checks.instances(dir)
