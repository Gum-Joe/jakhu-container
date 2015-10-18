get = require './get.js'
fs = require 'fs'
cli = require 'cli-color'

warn = cli.cyanBright('tub ')+cli.yellowBright('WARN: ')

errc = cli.cyanBright('tub ')+cli.redBright('ERR: ')
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
        console.log warn+'a .web.yml was not found for instance "'+getin[i]+'"'
      i++
  else
    if fs.existsSync(args+'/'+getin[i]+'/.web.yml') != true
      console.log 'ERR: a .web.yml was not found!'
      process.exit(1)
