# Starts app and sends back output
{spawn} = require 'child_process'

run = (sh) ->
  # body...
  # Start start.sh
    return

  ls = spawn('bash', ['./start.sh'])
  ls.stdout.on 'data', (data) ->
    console.log 'data:'+data
    return
  ls.stderr.on 'data', (data) ->
    console.log 'errors: ' + data
    return
  ls.on 'close', (code) ->
    console.log 'Exited with code ' + code
    return
