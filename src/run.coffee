{spawnSync} = require 'child_process'
{spawn} = require 'child_process'
{fail} = require 'assert'
{logback} = require './logger.js'
exports.runImage = (image, args) ->
  # body...
  if image == undefined
    fail('undefined', null, 'No image was specified')
  if args == undefined
    fail('undefined', null, 'Good job for telling us what image you want, but please use null if you do not want any args.')
  if typeof args == 'string'
    fail('undefined', null, 'Args must be an array, or a bug will attck this container')
  ls = spawn('docker', [
    'run'
    args
    image
    ])
  ls.stdout.on 'data', (data) ->
    console.log data
    return
  ls.stderr.on 'data', (data) ->
    console.log 'Errors: ' + data
    return
  ls.on 'close', (code) ->
    console.log 'Exited with code ' + code
    return

exports.run = (cmd, args) ->
  # body...
  if cmd == undefined
    fail('undefined', null, 'No command was specified')
  if args == undefined
    fail('undefined', null, 'Good job for telling us what you want to execute, but please use null if you do not want any args.')
  if typeof args == 'string'
    fail('undefined', null, 'Args must be an array, or a bug will attck this container')
  ls = spawn(cmd, args)
  ls.stdout.on 'data', (data) ->
    console.log ''+data
    return
  ls.stderr.on 'data', (data) ->
    console.log 'Errors: ' + data
    return
  ls.on 'close', (code) ->
    console.log 'Exited with code ' + code
    return
  #return
  # ls.stdout.on 'data', (data) ->
  #   console.log 'data:'+data
  #   return
  # ls.stderr.on 'data', (data) ->
  #   console.log 'errors: ' + data
  #   return
  # ls.on 'close', (code) ->
  #   console.log 'Exited with code ' + code
  #   return

exports.runSync = (cmd, args) ->
  # body...
  if cmd == undefined
    fail('undefined', null, 'No command was specified')
  if args == undefined
    fail('undefined', null, 'Good job for telling us what you want to execute, but please use null if you do not want any args.')
  if typeof args == 'string'
    fail('undefined', null, 'Args must be an array, or a bug will attck this container')
  ls = spawnSync(cmd, args)
  console.log 'data: '+ls.stdout.toString 'utf8'
  console.log 'errors: '+ls.stderr.toString 'utf8'

exports.runContainer = (id, port, pub) ->
  # body...
  ls = spawn('docker', ['run', '-p', pub+':'+port, 'webos/container'+id])
  ls.stdout.on 'data', (data) ->
    console.log 'data:'+data
    return
  ls.stderr.on 'data', (data) ->
    console.log 'errors: ' + data
    return
  ls.on 'close', (code) ->
    console.log 'Exited with code ' + code
    return

exports.runSend = (cmd, args, id, parsed) ->
  # body...
  if cmd == undefined
    fail('undefined', null, 'No command was specified')
  if args == undefined
    fail('undefined', null, 'Good job for telling us what you want to execute, but please use null if you do not want any args.')
  if typeof args == 'string'
    fail('undefined', null, 'Args must be an array, or a bug will attck this container')
  ls = spawn(cmd, args)
  ls.stdout.on 'data', (data) ->
    @host = 'http://localhost:8080/api/tubs/log'
    logback({id: id, name: parsed.name, code: '300', location: parsed.public, data: data}, @host, 'POST')
    console.log ''+data
    return
  ls.stderr.on 'data', (data) ->
    logback({id: id, name: parsed.name, code: '300', location: parsed.public, data: data})
    console.log 'Errors: ' + data
    return
  ls.on 'close', (code) ->
    console.log 'Exited with code ' + code
    return
