# Parse YAML to get config
parse = require './libs/yaml.js'
fs = require 'fs'
path = require 'path'
get = require './libs/get.js'
checks = require './libs/checks.js'
parse = require './libs/parse.js'
{spawn} = require 'child_process'
# Read instances

start = (args, dir) ->
  # Check instances
  checks.instances(dir, true)
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
  ls = spawn('ls', ['./'])

  ls.stdout.on('data', (data) ->
    console.log('stdout: ' + data)
  );

  ls.stderr.on('data', (data) ->
    console.log('stderr: ' + data)
  );

  ls.on('close', (code) ->
    console.log('child process exited with code ' + code)
    );
  return 'Done'
  # start

start('test', 'instances')
