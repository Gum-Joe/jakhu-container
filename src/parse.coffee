YAML = require 'yamljs'
fs = require 'fs'
assert = require 'assert'
cli = require 'cli-color'

errc = cli.cyanBright('\ntub ')+cli.redBright('ERR: ')

exports.parse = (file) ->
  # body...
  if fs.existsSync(file) != true
    console.log errc+'A .web.yml was not found! Check to see if it exists'
    assert.fail('EROENT', null, 'A .web.yml was not found! Check to see if it exists')
  else
    return YAML.parse(fs.readFileSync(file,'utf8'))
