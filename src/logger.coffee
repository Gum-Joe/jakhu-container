PythonShell = require('python-shell')
assert = require('assert')

exports.logback = (data, route, type, dir) ->
  # body...
  if type != 'GET' and type != 'get' and type != 'POST' and type != 'post' and type != 'PUT' and type != 'put' and type != 'DELETE' and type != 'delete'
    assert.fail 'invalid', null, 'Invalid method - values are GET, POST, PUT or DELETE'
    process.exit 1
  if type == 'POST' or 'post'
    options = args: [
      type
      route
      data
    ]
    PythonShell.run 'app.py', options, (err, results) ->
      if err
        throw err
      # results is an array consisting of messages collected during execution
      console.log 'results: %j', results
      return
  return
