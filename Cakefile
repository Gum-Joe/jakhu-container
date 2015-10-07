fs = require 'fs'

exec = require 'child_process'

install = (callback) ->
  exec.exec('coffee -o libs -c src', (stdout, stderr, error) ->
    if stdout != null
      console.log stdout
    else if stderr
      # body...
      console.log "Error!\n"+stderr
  )

test = (callback) ->
  exec.exec('coffee -o test -c test/src', (stdout, stderr, error) ->
    if stdout != null
      console.log stdout
    else if stderr
      # body...
      console.log "Error!\n"+stderr
  )

task 'install', 'Build lib/ from src/', ->
  install()

task 'test', 'Build test/ from test/src', ->
  install()
