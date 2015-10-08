fs = require 'fs'
path = require 'path'

exports.getin = (srcpath) ->
  # body...
  return fs.readdirSync(srcpath).filter((file) ->
    return fs.statSync(path.join(srcpath, file)).isDirectory();
  );
