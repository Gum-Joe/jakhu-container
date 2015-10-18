# Ruby generator
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
  # RVM
  if parsed.ruby == 'latest'
    @array = 'echo Updating ruby...\necho rvm install ruby-head\nrvm install ruby-head\n'
    fs.appendFileSync @con, @array
  else
    @array = 'echo Updating ruby...\necho rvm install '+parsed.ruby+'\nrvm install '+parsed.ruby+'\n'
    fs.appendFileSync @con, @array
  @use = 'echo rvm use '+parsed.ruby+'\nrvm use '+parsed.ruby
  fs.appendFileSync @con, @use
  @ver = '\necho ruby --version\nruby --version\n'
  fs.appendFileSync @con, @ver
  @bundle = 'echo Installing bundle...\necho gem install bundle\ngem install bundle\n'
  fs.appendFileSync @con, @bundle
  # Required
  if parsed.require != undefined
    i = 0
    while i < parsed.require.length
      if parsed.require[i] == 'nodejs'
        @nodejs = 'echo Installing nodejs...\ncurl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash\n. ~/.nvm/nvm.sh\nnvm install stable\n'
        fs.appendFileSync @con, @nodejs
      if parsed.require[i] == 'python2'
        @python = 'echo Installing python 2...\necho apt-get install -y python\napt-get install -y python\n'
        fs.appendFileSync @con, @python
      if parsed.require[i] == 'python'
        @p = 'echo Installing python...\necho apt-get install -y python3\napt-get install -y python3\n'
        fs.appendFileSync @con, @p
      if parsed.require[i] == 'java'
        @javap = 'openjdk-7-jre openjdk-7-jdk maven ant'
        @java = 'echo Installing java7...\necho apt-get install -y '+@javap+'\napt-get install -y '+@javap+'\n'
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
        fs.appendFileSync @con, 'echo '+build.script[b]+@enter+build.script[b]+@enter
        b++
    # if
  # Create docker file in /tmp
  @gpg = 'gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3'
  @docker = './.tubs/tub'+@id+'/Dockerfile'
  @from = 'FROM ubuntu:latest\nRUN apt-get update\nRUN apt-get install -y curl\nRUN apt-get install -y git-core\n'
  @lang = parsed.language
  @rubyi = 'RUN echo Installing prerequisites...\nRUN apt-get install -y gnupg\n'
  @ruby = 'RUN echo Installing ruby...\nRUN apt-get install -y ruby\n'
  @rvm = 'RUN echo Installing rvm...\nRUN '+@gpg+'\nRUN curl -sSL https://get.rvm.io | bash\n'
  @rvm = 'RUN echo Installing rails and bundle...\nRUN gem install bundle rails\n'
  fs.openSync @docker, 'w'
  fs.appendFileSync @docker, @from
  fs.appendFileSync @docker, @rubyi
  fs.appendFileSync @docker, @ruby
  fs.appendFileSync @docker, @rvm

  @dockerfile = 'COPY .tubs/tub'+@id+' /container\nCOPY '+dirw+' /container/app\nEXPOSE '+parsed.port+'\nCMD cd /container && sh ./start.sh'
  fs.appendFileSync @docker, @dockerfile
  runSend('sh', ['~/.web/tubs/build.sh', '.tubs/tub'+@id+'/Dockerfile', 'webos/tub'+@id, parsed.public+':'+parsed.port, 'webos/tub'+@id], @id, parsed)
        # body...
  logger.logback(form: {id: @id, name: parsed.name, status: 'Running', code: '300', location: parsed.public}, 'http://localhost:8080/api/tubs/update/status', 'POST', 'node_modules/web-os-logger/')
