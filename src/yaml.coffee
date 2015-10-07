YAML = require 'yamljs'
fs = require 'fs'

module.exports =
  getdata(ins) ->
    # body...
    return YAML.parse(fs.readFileSync('../../instances/'+ins+'.web.yml','utf8'))
