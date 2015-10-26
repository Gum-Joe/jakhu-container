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
cli = require 'cli-color'
# Read instances
'use strict';

warn = cli.cyanBright('tub ')+cli.yellowBright('WARN: ')
tub = cli.cyanBright('tub ')
info = tub+cli.greenBright('info ')
run = tub+cli.magentaBright('runner ')
errc = cli.cyanBright('tub ')+cli.redBright('ERR: ')

exports.start = (args, dir) ->
  # Check instances
  checks.instances(dir, true)
  # .web.yml

  # Parse YAML
  @parsed = parse.parse(dir+'/'+args+'/.web.yml')
  if parsed.nodejs != undefined && process.env.WEB_DOCKER == false
    console.log warn+'Nodejs version '+ parsed.nodejs+' is required. \nPlease consider using Docker'
  if parsed.ruby != undefined && process.env.WEB_DOCKER == false
    console.log warn+'Ruby version '+ parsed.ruby+' is required. \nPlease consider using Docker'
  if parsed.python != undefined && process.env.WEB_DOCKER == false
    console.log warn+'Python version '+ parsed.python+' is required. \nPlease consider using Docker'
    if parsed.python == 3
      console.log warn+'You are using Python 3. All python cmd commands must be ran using "python3"'
  if parsed.language == 'python'
    if parsed.python == undefined
      console.log errc+'Please specify a python version as python 2 and 3 are different'
      process.exit 1
  if parsed.nodejs == 'latest'
    console.log warn+'latest is not a nodejs version. For the latest version, use "stable" instead. We wil swap "latest" for "stable" this time'
  if process.env.WEB_DOCKER != false
    console.log '\n'+info+'Pulling Docker images...'
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
      console.log info+'Already pulled images'

  console.log '\n'+run+'Starting Web-app '+parsed.name
  console.log info+'Language: '+parsed.language

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
