# Parse YAML to get config
parse = require './libs/yaml.js'
fs = require 'fs'
path = require 'path'
get = require './libs/get.js'
checks = require './libs/checks.js'
parse = require './libs/parse.js'
exec = require 'child_process'
# Read instances

start = (args, dir) ->
  # Check instances
  checks.instances(dir)
  # Parse YAML
  parsed = parse.parse(dir+'/'+args+'/.web.yml')
  console.log 'Starting Web-app '+parsed.name
  console.log 'Language: '+parsed.language
  if parsed.nodejs != undefined && process.env.WEB_DOCKER != true
    console.log 'Nodejs version '+ parsed.nodejs+' is required. \nPlease consider using Docker'
  if parsed.ruby != undefined && process.env.WEB_DOCKER != true
    console.log 'Ruby version '+ parsed.ruby+' is required. \nPlease consider using Docker'
  if parsed.python != undefined && process.env.WEB_DOCKER != true
    console.log 'Python version '+ parsed.python+' is required. \nPlease consider using Docker'
  log = exec.spawn(parsed.start)
  log.stdout.on('data', (data) ->
    return 'h'
    console.log data
  )

  log.stderr.on('data', (data) ->
    return 'h'
    console.log data
    # body...
  )

  log.on
  return 'Done'
  # start

start('test', 'instances')
