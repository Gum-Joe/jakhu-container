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
  fs.writeFileSync(@con, @sharray, 'utf8');
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
    @cd = 'cd ./app'
    @global = parsed.global
    @enter = '\n'
    fs.appendFileSync @con, @cd
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
    console.log '\nStart script Generated'
  if lang =='ruby'
    console.log 'h'
