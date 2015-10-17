fs = require 'fs'
mkdirp = require 'mkdirp'
logger = require '../libs/logger.js'
{run} = require '../libs/run.js'
{runSend} = require '../libs/run.js'
{runSync} = require '../libs/run.js'
runc = require '../libs/run.js'
generate = require '../libs/generator.js'
exports.script = (lang, parsed, options, dirw) ->
  # Main stuff
  @sharray = '#!/usr/bin/bash\necho Preparing to run web-app...\n'
  @id = Math.floor Math.random() * 9999999999999999 + 1
  @con = '.tubs/tub'+@id+'/start.sh'
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
  # env
  if parsed.env != undefined
    fs.appendFileSync @con, 'echo Exporting Enviroment...\n'
    fs.appendFileSync @con, 'export CONTAINER_ID='+@id+'\n'
    fs.appendFileSync @con, 'export CONTAINER_NAME='+parsed.name+'\n'
    fs.appendFileSync @con, 'export PORT='+parsed.port+'\n'
    if parsed.public == undefined && isNaN parsed.port
      fs.appendFileSync @con, 'export PUBLIC_PORT=3030\n'
    else
      fs.appendFileSync @con, 'export PUBLIC_PORT='+parsed.public+'\n'
    fs.appendFileSync @con, 'echo Setting enviroment varibles from .web.yml...\n'
    v = 0
    while v < parsed.env.length
      fs.appendFileSync @con, 'export '+parsed.env[v]+'\n'
      v++
  if parsed.language == 'nodejs'
    generate.nodejs.generate(parsed, @id, @con, dirw)
runcon = (arg, a, b) ->
  # body...
  console.log 'Starting...'
  runc.runContainer(arg, a, b)
