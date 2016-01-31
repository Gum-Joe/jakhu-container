# Tub class
YAML = require 'yamljs'
class TubConfig
  constructor: (tub, appdir, yml) ->
    # body...
    @dir = appdir
    @tub = tub
    @file = "#{@dir}/.jakhu/#{@tub}tub_config.yml"
    @yml = yml
    @yaml = {}
    fs.openSync @file
  create: (args) ->
    # body...
    @yaml.name = @tub
    @yaml.language = @yml.language
    @yaml.dir = "/app"
    @yaml.app = @yml.name
  write: (args) ->
    # body...
    @sy = YAML.stringify(@yaml)
    fs.appendFileSync @file, @sy

genTubConfig = (tub, appdir, yml) ->
  # body...
  tc = new TubConfig(tub, appdir, yml)
  tc.create()
  tc.write()

module.exports = {genTubConfig: genTubConfig}
