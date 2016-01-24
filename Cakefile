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
  exec.exec('coffee -c app.coffee', (stdout, stderr, error) ->
    if stdout != null
      console.log stdout
    else if stderr
      # body...
      console.log "Error!\n"+stderr
  )

test = (callback) ->
  exec.exec('coffee -o test -c src/test', (stdout, stderr, error) ->
    if stdout != null
      console.log stdout
    else if stderr
      # body...
      console.log "Error!\n"+stderr
  )

watchsrc = (callback) ->
  exec.exec('coffee --watch -o libs -c src', (stdout, stderr, error) ->
    console.log stdout
    if stderr
      # body...
      console.log "Error!\n"+stderr
  )

task 'install', 'Build lib/ from src/ and build bin/ from src/bin/', ->
  install()

task 'test', 'Build test/ from test/src', ->
  install()
  test()

task 'src', 'Build libs/ from src/ and watch', ->
  watchsrc()
