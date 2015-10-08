YAML = require 'yamljs'
fs = require 'fs'

exports.parse = (file) ->
  # body...
  return YAML.parse(fs.readFileSync(file,'utf8'))
