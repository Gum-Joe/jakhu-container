# Parse YAML to get config
parse = require './libs/yaml.js'
fs = require 'fs'
path = require 'path'
get = require './libs/get.js'
checks = require './libs/checks.js'
parse = require './libs/parse.js'
{spawn} = require 'child_process'
{script} = require './libs/gen.js'
# Read instances
'use strict';

start = (args, dir) ->
  # Check instances
  checks.instances(dir, true)
  # Parse YAML
  @parsed = parse.parse(dir+'/'+args+'/.web.yml')
  if parsed.nodejs != undefined && process.env.WEB_DOCKER == false
    console.log 'WARN: Nodejs version '+ parsed.nodejs+' is required. \nPlease consider using Docker'
  if parsed.ruby != undefined && process.env.WEB_DOCKER == false
    console.log 'WARN: Ruby version '+ parsed.ruby+' is required. \nPlease consider using Docker'
  if parsed.python != undefined && process.env.WEB_DOCKER == false
    console.log 'WARN: Python version '+ parsed.python+' is required. \nPlease consider using Docker'
  if parsed.nodejs == 'latest'
    console.log 'WARN: latest is not a nodejs version. For the latest version, use "stable" instead. We wil swap "latest" for "stable" this time'

  if process.env.WEB_DOCKER != undefined
    console.log 'Pulling Docker image'

  console.log '\nStarting Web-app '+parsed.name
  console.log 'Language: '+parsed.language

  if process.env.WEB_DOCKER != false
    script(parsed.language, parsed)
  return 'Done'
  # start


start('test', 'instances')
