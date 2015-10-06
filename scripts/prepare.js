// Prepare src
var os = require('os');
var fs = require('fs');
if(os.type() === "Linux"){
  console.log("Linux OS detected. \nUsing execlin.h as exec.h");
  fs.createReadStream('./src/execlin.h').pipe(fs.createWriteStream('./src/exec.h'));
} else if (os.type() === "Windows_NT") {
  console.log("Windows OS detected. \nUsing execwin.h as exec.h");
  fs.createReadStream('./src/execwin.h').pipe(fs.createWriteStream('./src/exec.h'));
} else {
  console.log("Other OS detected. \nUsing execlin.h as exec.h");
  fs.createReadStream('./src/execlin.h').pipe(fs.createWriteStream('./src/exec.h'));
}
