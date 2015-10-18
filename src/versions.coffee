fs = require 'fs'
# Version file
exports.generate = (id) ->
  # body...
  @id = id
  @ver = '.tubs/tub'+@id+'/versions.sh'
  @shebang = '#!/usr/bin/bash\n'
  fs.appendFileSync @ver, @shebang
  if parsed.language == 'nodejs'
    @v = 'echo node --version\nnode --version\necho npm --version\nnpm --version\necho nvm --version\nnvm --version\n'
    fs.appendFileSync @ver, @v

  if parsed.language == 'ruby'
    @v = 'echo ruby --version\nruby --version\necho rvm --version\nrvm --version\necho gem --version\ngem --version\necho bundle --version\nbundle --version\necho rails --version\nrails --version'
    fs.appendFileSync @ver, @v

  if parsed.language == 'python'
    @v = 'echo python --version\npython --version\necho pip --version\npip --version\n'
    fs.appendFileSync @ver, @v
