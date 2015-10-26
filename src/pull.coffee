#Pull images
YAML = require 'yamljs'
fs = require 'fs'
parse = require './parse.js'
{exec} = require 'child_process'
{spawn} = require 'child_process'

exports.pullImages = (file, options) ->
  # body...
  images = parse.parse(file)
  im = 0
  if options.out == undefined
    while im < images.images.length
      exec('docker pull '+images.images[im])
      im++
  else if options.out == true
    while im < images.images.length
      ls = spawn('docker', ['pull '+images.images[im]])
      ls.stdout.on 'data', (data) ->
        console.log 'Stdout: ' + data
        return
      ls.stderr.on 'data', (data) ->
        console.log 'Errors: ' + data
        return
      ls.on 'close', (code) ->
        console.log 'Exited with code ' + code
        return
      im++
