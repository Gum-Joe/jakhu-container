fs = require 'fs'
exports.script = (lang, parsed, options) ->
  # Main stuff
  @con = 'startcon.sh'
  @sharray = '#!/usr/bin/bash\necho Preparing to run web-app...\n'
  # Open script
  fs.openSync @con, 'w'
  # Chmod
  fs.chmodSync @con, '700'
  fs.chmodSync @con, '777'
  # Write shebang
  fs.writeFileSync @con, @sharray, 'utf8'
  # env
  if parsed.env != undefined
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
