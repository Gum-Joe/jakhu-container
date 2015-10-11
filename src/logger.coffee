PythonShell = require('python-shell')
assert = require('assert')

exports.logback = (data, route, type, dir) ->
  # body...
  if type != 'GET' and type != 'get' and type != 'POST' and type != 'post' and type != 'PUT' and type != 'put' and type != 'DELETE' and type != 'delete'
    assert.fail 'invalid', null, 'Invalid method - values are GET, POST, PUT or DELETE'
    process.exit 1
  if type == 'POST' or 'post'
    request = require 'request'
    request.post route, data, (error, response, body) ->
      # Uncomment - soon
      #if error
        #assert.fail error, null, 'ERR: Could not report back to Web-OS server'
      #if response.statusCode != 200 and response.statusCode != 304
        #assert.fail error, null, 'ERR: Could not report back to Web-OS server. Is the server running?'
