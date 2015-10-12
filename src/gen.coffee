fs = require 'fs'
mkdirp = require 'mkdirp'
logger = require '../libs/logger.js'
{run} = require '../libs/run.js'
exports.script = (lang, parsed, options) ->
  # Main stuff
  @sharray = '#!/usr/bin/bash\necho Preparing to run web-app...\n'
  @id = Math.floor Math.random() * 9999999999999999 + 1
  @con = 'tmp/container'+@id+'/start.sh'
  logger.logback({id: @id, name: parsed.name, status: 'Preparing', code: '200'}, 'http://localhost:8080/api/container/status/update', 'POST', 'python')
  # Dir for files
  fs.mkdirSync('./tmp/container'+@id)
  # Open script
  fs.openSync @con, 'w'
  # Chmod
  fs.chmodSync @con, '700'
  fs.chmodSync @con, '777'
  # Write shebang
  fs.writeFileSync @con, @sharray, 'utf8'
  # env
  if parsed.env != undefined
    fs.appendFileSync @con, 'echo Exporting Enviroment...\necho Setting default env...\n'
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

  # Update Nodejs/ruby/python
  if lang == 'nodejs'
    if parsed.nodejs == 'latest'
      @array = 'echo Updating nodejs...\nnvm install stable\n'
      fs.appendFileSync @con, @array
    else
      @array = 'echo Updating nodejs...\nnvm install '+parsed.nodejs+'\n'
      fs.appendFileSync @con, @array
    # Required
    if parsed.require != undefined
      i = 0
      while i < parsed.require.length
        if parsed.require[i] == 'ruby'
          @ruby = 'echo Installing ruby...\nsudo apt-get install ruby-full\necho Installing bundle...\ngem install bundle\n'
          fs.appendFileSync @con, @ruby
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
    if parsed.build != undefined
      # body...
      @build = parsed.build
      fs.appendFileSync @con, 'echo Building Web-app...\n'
      b = 0
      while b < build.script.length
        fs.appendFileSync @con, build.script[b]+@enter
        b++
    # if
    fs.appendFileSync @con, 'echo Starting Web-app...\n'
    if parsed.port != undefined
      fs.appendFileSync @con, 'export PORT='+parsed.port+@enter
    fs.appendFileSync @con, parsed.start
    console.log '\nStart script Generated'
  if lang =='ruby'
    console.log 'h'
  # Create docker file in /tmp
  console.log 'Generating dockerfile...'
  @docker = './tmp/container'+@id+'/Dockerfile'
  @from = 'FROM gumjoe/web-os-images:'
  @lang = parsed.language
  fs.openSync @docker, 'w'
  if @lang == 'nodejs'
    fs.appendFileSync @docker, @from+'nodejs\n'
  if @lang == 'ruby'
    fs.appendFileSync @docker, @from+'ruby\n'
    if @lang == 'python'
      if parsed.version == '2'
        fs.appendFileSync @docker, @from+'python2.7\n'
      else if parsed.python == '3'
        console.log 'WARN: You are using Python 3.0. All python cmd commands must be ran using "python3"'
        fs.appendFileSync @docker, @from+'python3.0\n'
  @dockerfile = 'COPY . /container/app\nCOPY tmp/container'+@id+'/start.sh /container/start.sh\nCMD cd /container && start.sh'
  fs.appendFileSync @docker, @dockerfile
  console.log 'Preparing to start...'
  run('docker', ['build', '-f', 'tmp/container'+@id+'/Dockerfile', '-t','weboscontainer/'+@id, '.'])

        # body...
  logger.logback({id: @id, name: parsed.name, status: 'Running', code: '300', location: parsed.public}, 'http://localhost:8080/api/container/status/update', 'POST', 'node_modules/web-os-logger/')
