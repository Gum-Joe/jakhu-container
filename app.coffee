# Parse YAML to get config
parse = require './libs/yaml.js'
fs = require 'fs'
path = require 'path'
get = require './libs/get.js'
checks = require './libs/checks.js'
parse = require './libs/parse.js'
{spawn} = require 'child_process'
{exec} = require 'child_process'
{script} = require './libs/gen.js'
{run} = require './libs/run.js'
pull = require './libs/pull.js'
YAML = require 'yamljs'
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
    if parsed.python == '3'
      console.log 'WARN: You are using Python 3. All python cmd commands must be ran using "python3"'
  if parsed.nodejs == 'latest'
    console.log 'WARN: latest is not a nodejs version. For the latest version, use "stable" instead. We wil swap "latest" for "stable" this time'
  if process.env.WEB_DOCKER != false
    console.log '\nPulling Docker images...'
    # Parse config/images.yml
    @images = parse.parse('config/images.yml')
    @dateo = new Date().getDate()
    if images.date != @dateo
      im = 0
      while im < images.images.length
        exec('docker pull '+images.images[im])
        im++
      images.date = @dateo
      @write = YAML.stringify(@images, 4);
      fs.writeFileSync('config/images.yml', @write)
    else
      console.log 'Already pulled images'

  console.log '\nStarting Web-app '+parsed.name
  console.log 'Language: '+parsed.language

  if process.env.WEB_DOCKER != false
    script(parsed.language, parsed, null, dir+'/'+args)
  return 'Done'
  # start

exports.pullImages = (dir) ->
  # body...
  return pull.pullImages(dir)

exports.run = (image, args) ->
  # body...
  return runImage(image, args)

start('web', 'instances')
