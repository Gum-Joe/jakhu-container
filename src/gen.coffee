fs = require 'fs'
mkdirp = require 'mkdirp'
logger = require '../libs/logger.js'
{run} = require '../libs/run.js'
{runSend} = require '../libs/run.js'
{runSync} = require '../libs/run.js'
runc = require '../libs/run.js'
generate = require '../libs/generator.js'
version = require '../libs/versions.js'
exports.script = (lang, parsed, options, dirw) ->
  # Main stuff
  @sharray = '#!/usr/bin/bash\necho Preparing to run web-app...\necho . /container/env.sh\n. /container/env.sh\n'
  @id = Math.floor Math.random() * 9999999999999999 + 1
  @con = '.tubs/tub'+@id+'/build.sh'
  @source = '.tubs/tub'+@id+'/env.sh'
  logger.logback(form: {id: @id, name: parsed.name, status: 'Preparing', code: '200'}, 'http://localhost:8080/api/tubs/update/status', 'POST')
  # Dir for files
  if fs.existsSync '.tubs' != true
    fs.mkdirSync('./.tubs')
  fs.mkdirSync('./.tubs/tub'+@id)
  # Open script
  fs.openSync @con, 'w'
  # Chmod
  fs.chmodSync @con, '700'
  fs.chmodSync @con, '777'
  # Write shebang
  fs.writeFileSync @con, @sharray, 'utf8'

  fs.appendFileSync @source, 'echo Exporting Enviroment...\n'
  fs.appendFileSync @source, 'export CONTAINER_ID='+@id+'\n'
  fs.appendFileSync @source, 'export CONTAINER_NAME='+parsed.name+'\n'
  fs.appendFileSync @source, 'export PORT='+parsed.port+'\n'
  if parsed.public == undefined && isNaN parsed.port
    fs.appendFileSync @source, 'export PUBLIC_PORT=3030\n'
  else
    fs.appendFileSync @source, 'export PUBLIC_PORT='+parsed.public+'\n'
  # env
  if parsed.env != undefined
    fs.appendFileSync @source, 'echo Setting enviroment varibles from .web.yml...\n'
    v = 0
    while v < parsed.env.length
      fs.appendFileSync @source, 'export '+parsed.env[v]+'\n'
      v++

  @start = '.tubs/tub'+@id+'/start.sh'
  @enter = '\n'
  fs.appendFileSync @start, '#!/usr/bin/bash\n'
  fs.appendFileSync @start, 'echo Starting Web-app...\ncd /container\nsh ./versions.sh\n. ./env.sh\ncd app\n'
  if parsed.port != undefined
    fs.appendFileSync @start, 'export PORT='+parsed.port+@enter
  fs.appendFileSync @start, parsed.start

  # Version file
  version.generate(@id)

  if parsed.language == 'nodejs'
    generate.nodejs.generate(parsed, @id, @con, dirw)
  if parsed.language == 'ruby'
    generate.ruby.generate(parsed, @id, @con, dirw)
  if parsed.language == 'python'
    generate.python.generate(parsed, @id, @con, dirw)
runcon = (arg, a, b) ->
  # body...
  console.log 'Starting...'
  runc.runContainer(arg, a, b)
