# Nodejs generater
fs = require 'fs'
mkdirp = require 'mkdirp'
logger = require '../../libs/logger.js'
{run} = require '../../libs/run.js'
{runSend} = require '../../libs/run.js'
{runSync} = require '../../libs/run.js'
runc = require '../../libs/run.js'
generator = require '../../libs/generator.js'

'use strict'

exports.generate = (parsed, idw, conw, dirw) ->
  # body...
  lang = parsed.language
  @con = conw
  @lang = parsed.language
  @id = idw
  # Update Nodejs/ruby/python
  if parsed.nodejs == 'latest'
    @array = 'echo Updating nodejs...\n. ~/.nvm/nvm.sh\necho nvm install stable\nnvm install stable\n'
    fs.appendFileSync @con, @array
  else if parsed.nodejs == undefined
    # body...
    @array = 'echo Installing nodejs...\n. ~/.nvm/nvm.sh\necho nvm install stable\nnvm install stable\n'
    fs.appendFileSync @con, @array
  else
    @array = 'echo Updating nodejs...\necho nvm install '+parsed.nodejs+'\nnvm install '+parsed.nodejs+'\n'
    fs.appendFileSync @con, @array
  # Required
  if parsed.require != undefined
    i = 0
    while i < parsed.require.length
      if parsed.require[i] == 'ruby'
        @ruby = 'echo Installing ruby...\nsudo apt-get install -y ruby\necho Installing bundle...\ngem install bundle\n'
        fs.appendFileSync @con, @ruby
      if parsed.require[i] == 'python2'
        @python = 'echo Installing python...\necho apt-get install -y python\napt-get install -y python'
        fs.appendFileSync @con, @python
      if parsed.require[i] == 'python'
        @p = 'echo Installing python...\necho apt-get install -y python3\napt-get install -y python3'
        fs.appendFileSync @con, @p
      if parsed.require[i] == 'java'
        @javap = 'openjdk-7-jre openjdk-7-jdk maven ant\n'
        @java = 'echo Installing java7...\necho apt-get install -y '+@javap+'apt-get install -y '+@javap
        fs.appendFileSync @con, @java
      i++
    # Global deps
    @cd = '\ncd ./app\n'
    @global = parsed.global
    @enter = '\n'
    if parsed.global != undefined
      if global.npm != undefined
        # body...
        @npm = 'echo Installing global npm modules...\nnpm install -g '
        fs.appendFileSync @con, @npm
        n = 0
        while n < global.npm.length
          fs.appendFileSync @con, global.npm[n]+' '
          n++
        fs.appendFileSync @con, @enter
      if global.gem != undefined
        # body...
        @gem = 'echo Installing gems...\ngem install '
        fs.appendFileSync @con, @gem
        g = 0
        while g < global.npm.length
          if global.gem[g] != undefined
            # body...
            fs.appendFileSync @con, global.gem[g]+' '
          g++
      # if parsed.global
    fs.appendFileSync @con, @cd
    # Install
    if parsed.build != undefined
      # body...
      build = parsed.build
      install = parsed.install
      fs.appendFileSync @con, 'echo Installing dependencies...\n'
      inc = 0
      while inc < install.length
        fs.appendFileSync @con, 'echo '+install[inc]+@enter
        fs.appendFileSync @con, install[inc]+@enter
        inc++
      fs.appendFileSync @con, 'echo Building...\n'
      b = 0
      while b < build.script.length
        fs.appendFileSync @con, build.script[b]+@enter
        b++
    # if
  # Create docker file in /tmp
  @docker = './.tubs/tub'+@id+'/Dockerfile'
  @from = 'FROM ubuntu:latest\n'
  @lang = parsed.language
  fs.openSync @docker, 'w'
  if @lang == 'nodejs'
    fs.appendFileSync @docker, @from+'RUN apt-get install -y curl\nRUN apt-get install -y git-core\nRUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash\n'
  if @lang == 'ruby'
    fs.appendFileSync @docker, @from+'ruby\n'
    if @lang == 'python'
      if parsed.version == '2'
        fs.appendFileSync @docker, @from+'python2.7\n'
      else if parsed.python == '3'
        console.log 'WARN: You are using Python 3.0. All python cmd commands must be ran using "python3"'
        fs.appendFileSync @docker, @from+'python3.0\n'
  @dockerfile = '\nCOPY .tubs/tub'+@id+' /container\nCOPY '+dirw+' /container/app\nRUN cd /container; sh ./build.sh\nEXPOSE '+parsed.port+'\nCMD cd /container && sh ./start.sh'
  fs.appendFileSync @docker, @dockerfile
  runSend('sh', ['~/.web/tubs/build.sh', '.tubs/tub'+@id+'/Dockerfile', 'webos/tub'+@id, parsed.public+':'+parsed.port, 'webos/tub'+@id], @id, parsed)
        # body...
  logger.logback(form: {id: @id, name: parsed.name, status: 'Running', code: '300', location: parsed.public}, 'http://localhost:8080/api/tubs/update/status', 'POST', 'node_modules/jakhu-logger/')
