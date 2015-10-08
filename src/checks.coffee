exports.instances = (args) ->
  # body...
  getin = get.instances.getin(args)
  # body...
  # Checks
  for i in getin
    if fs.existsSync(getin[i]+'/.web.yml') != true
      console.log 'WARN: a .web.yml was not found for instance '+geting[i]
