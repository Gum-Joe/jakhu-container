get = require './get.js'
fs = require 'fs'
exports.instances = (args, web) ->
  # body...
  if web == true
    # body...
    getin = get.instances.getin(args)
    # body...
    # Checks
    i = 0
    while i < getin.length
      if fs.existsSync(args+'/'+getin[i]+'/.web.yml') != true
        console.log 'WARN: a .web.yml was not found for instance "'+getin[i]+'"'
      i++
  else
    if fs.existsSync(args+'/'+getin[i]+'/.web.yml') != true
      console.log 'ERR: a .web.yml was not found!'
      process.exit(1)
