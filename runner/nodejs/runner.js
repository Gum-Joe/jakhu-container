var express = require('express');
var spawn = require('child_process').spwan
var app = express();

var port = process.env.COMTAINER_RECIEVER_PORT
app.listen(3001, function () {
  console.log('Listening...');
});

app.get('/', function (req, res) {
  res.send('Starting Web-app...')
});
