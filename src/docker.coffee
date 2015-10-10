{execSync} = require child_process

exports.pull = (image) ->
  # body...
  if image != undefined
    return 'Pulling docker image '+image
    return execSync 'docker pull '+image
  else
    return 'Pulling Docker images...'
