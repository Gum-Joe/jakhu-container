app.get('/', function (req, res) {
  // body...
  var cmd = exec('command');
  if(cmd.errors){
    throw new Error;
  }
  res.send('Output:'+cmd.stdout);
});
