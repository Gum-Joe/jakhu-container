# Handles incomming func

# @function startAppt()
# Starts a provided web-app
# @param app The app to start
# @param author The author of the app
YAML = require 'yamljs'
instances = "instances"
{genDockerFile} = require './libs/docker.js'
debug = require('debug')('container:starter')
class App
  constructor: (author, app) ->
    # body...
    @author = author
    @app = app
    @tubs = []
    @dir = "#{instances}/#{@app}"
    @ymlfile = "#{@dir}/.jakhu.yml"
    @parsedYml = YAML.load(@ymlfile)
  addTub: (tubname) ->
    # body...
    @tubs.push tubname
  autoTubs: () ->
    # body...
    i = 0
    while i < @parsedYml.tubs.length
      # Create files
      genDockerFile(@parsedYml.tubs[i], @dir, @parsedYml)
      i++

  final: () ->
    console.log @parsedYml
  createDockerFiles: () ->
    # body...
    i = 0
    while i < @tubs.length
      # Create files
      genDockerFile(@tubs[i], @dir, @parsedYml)
      i++
  start: () ->
    genDockerFile()
      # body...

a = new App("meap", "nodejs")
a.addTub('default')
a.autoTubs()
a.createDockerFiles()
a.final()


module.exports = { App: App }
