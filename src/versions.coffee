fs = require 'fs'
# Version file
exports.generate = (id) ->
  # body...
  @id = id
  @ver = '.tubs/tub'+@id+'/versions.sh'
  @shebang = '#!/usr/bin/bash\n'
  fs.appendFileSync @ver, @shebang
  if parsed.language == 'nodejs'
    @v = 'echo node -v\nnode -v\necho npm -v\nnpm -v\necho nvm -v\nnvm -v\n'
    fs.appendFileSync @ver, @v

  if parsed.language == 'ruby'
    @v = 'echo ruby -v\nruby -v\necho rvm -v\nrvm -v\necho gem -v\ngem -v\necho bundle -v\nbundle -v\n'
    fs.appendFileSync @ver, @v

  if parsed.language == 'python'
    @v = 'echo python -v\npython -v\necho pip -v\npip -v\n'
    fs.appendFileSync @ver, @v
