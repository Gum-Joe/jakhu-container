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
    fs.appendFileSync @file, "FROM jakhu/#{lang}:latest\nRUN sudo chown -R jakhu /runner\nCOPY tub_config.yml ~/.jakhu/tub_config.yml\nCOPY . /app\n"
    fs.appendFileSync @file, "RUN mkdir ~/.jakhu\nADD tub_config.yml /home/jakhu/.jakhu/tub_config.yml\nRUN sudo git clone https://github.com/Gum-Joe/jakhu-runner ~/.jakhu/runner\nVOLUME ../.. /app\n"
  cwd: () ->
    fs.appendFileSync @file, 'CMD bash -c "sudo chmod 777 ~/.jakhu/runner && source /home/jakhu/.rvm/scripts/rvm && rvm use ruby-head && ruby ~/.jakhu/runner/bin/jakhurun start"'



genDockerFile = (tub, appdir, yml) ->
  # body...
  docker = new DockerFileDefault(tub, appdir)
  @compose = {}
  docker.image(yml.language)
  docker.cwd()
  # Create Compose YAML file
  f = 0
  while f < yml.tubs.length
    @compose[yml.tubs[f]] = build: ".."
    @compose[yml.tubs[f]] = dockerfile: "#{yml.tubs[f]}/Dockerfile"
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
