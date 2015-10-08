get = require './get.js'
fs = require 'fs'
exports.instances = (args) ->
  # body...
  getin = get.instances.getin(args)
  # body...
  # Checks
  i = 0
  while i < getin.length
    if fs.existsSync(args+'/'+getin[i]+'/.web.yml') != true
      console.log 'WARN: a .web.yml was not found for instance "'+getin[i]+'"'
    i++
