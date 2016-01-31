# Docker stuff
fs = require 'fs'
mkdirp = require 'mkdirp'
YAML = require 'yamljs'

# Gen docker file
createDockerFile = (dir) ->
  # body...
  if fs.existsSync(dir) != true
    mkdirp(dir)
  # Create file
  fs.open("#{dir}/Dockerfile", 'w', (err) ->
    # body...
    if err
      # body...
      throw new Error(err)
  )



# Docker class
class DockerFileDefault
  constructor: (tub, appdir) ->
    # body...
    @dir = appdir
    @tub = tub
    @file = "#{@dir}/.jakhu/#{@tub}/Dockerfile"
    @compose = {}
    createDockerFile("#{appdir}/.jakhu/#{tub}")
  image: (lang) ->
    fs.appendFileSync @file, "FROM jakhu/#{lang}:latest\nRUN sudo chown -R jakhu /runner\n"
  cwd: () ->
    fs.appendFileSync @file, 'CMD bash -c "sudo chmod 777 /runner/bin/jakhurun && source /home/jakhu/.rvm/scripts/rvm && rvm use ruby-head && /runner/bin/jakhurun start"'



genDockerFile = (tub, appdir, yml) ->
  # body...
  docker = new DockerFileDefault(tub, appdir)
  @compose = {}
  docker.image(yml.language)
  docker.cwd()
  # Create Compose YAML file
  f = 0
  while f < yml.tubs.length
    @compose[yml.tubs[f]] = build: "#{yml.tubs[f]}"
    @compose[yml.tubs[f]].ports = []
    if yml.public
      # body...
      @compose[yml.tubs[f]].ports.push("#{yml.public}:#{yml.port}")
    else
      @compose[yml.tubs[f]].ports.push("#{yml.port}:#{yml.port}")
    @compose[yml.tubs[f]].container_name = "#{yml.name}-tub-#{yml.tubs[f]}"
    f++
  # services
  f = 0
  while f < yml.services.length
    @compose[yml.services[f]] = image: yml.services[f], container_name: "#{yml.name}-service-#{yml.services[f]}"
    f++
  # Create dir
  mkdirp("#{appdir}/.jakhu")
  # append
  fs.open("#{appdir}/.jakhu/docker-compose.yml", 'w', (err) ->
    # body...
    if err
      # body...
      throw new Error(err)
  )
  fs.appendFileSync("#{appdir}/.jakhu/docker-compose.yml", YAML.stringify(@compose, 4))



module.exports = {genDockerFile: genDockerFile}
