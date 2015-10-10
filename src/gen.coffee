exports.script = (lang, parsed) ->
  # Main stuff
  @con = 'startcon.sh'
  @sharray = '#!/usr/bin/bash\necho Preparing to run web-app...\n'
  fs.openSync @con, 'w'
  # Chmod
  fs.chmodSync @con, '700'
  fs.chmodSync @con, '777'
  fs.writeFileSync(@con, @sharray, 'utf8');
  if lang == 'nodejs'
    if parsed.nodejs == 'latest'
      @array = 'echo Updating nodejs...\nnvm install stable\n'
      fs.appendFileSync @con, @array
    else
      @array = 'echo Updating nodejs...\nnvm install '+parsed.nodejs+'\n'
      fs.appendFileSync @con, @array
    if parsed.require != undefined
      i = 0
      while i < parsed.require.length
        if parsed.require[i] == 'ruby'
          @ruby = 'echo Installing ruby...\nsudo apt-get install ruby-full\necho Installing bundle...\ngem install bundle\n'
          fs.appendFileSync @con, @ruby
        i++
    # Add install
    @cd = 'cd ./app'
    fs.appendFileSync @con, @cd
    if parsed.install != undefined
      @j = 0
      while `j` < parsed.install.length
        if parsed.require[i] == 'ruby'
          @ruby = 'echo Installing ruby...\nsudo apt-get install ruby-full\necho Installing bundle...\ngem install bundle\n'
          fs.appendFileSync @con, @ruby
        j++
    console.log '\nStart script Generated'
  if lang =='ruby'
    console.log 'h'
