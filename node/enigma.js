#!/usr/bin/env node
var
  crypto    = require("crypto"),
  fs        = require('fs'),
  path      = require('path'),
  shtirlitz = {

    init: function(secret, file, decrypt) {
      var
        mod  = decrypt ? 'dec' : 'enc',
        pass = new Buffer(secret);
      return this[mod](pass, file);
    },

    rename: function(file) {
      var
        dir     = path.dirname(file),
        base    = path.basename(file),
        newbase = (/^\./.test(base) ? 'enc' : 'enc.') + base;

      return path.join(dir, newbase);
    },

    enc: function(pass, file) {
      var
        ename = this.rename(file),
        rstm  = fs.createReadStream(file),
        wstm  = fs.createWriteStream(ename);

      rstm
        .pipe(crypto.createCipher('aes-256-cbc', pass))
        .pipe(wstm)
        .on('finish', function() {
          console.log('encrypted to ' + ename);
        });
    },

    dec: function(pass, file) {
      var
        dechip = crypto.createDecipher('aes-256-cbc', pass),
        rstm   = fs.createReadStream(file);

      rstm.pipe(dechip).pipe(process.stdout);
    }

  };


if (process.argv[2] && process.argv[3]) {

  var
    mod  = process.argv[4] || null,
    pass = process.argv[2],
    file = process.argv[3];

  shtirlitz.init(pass, file, mod);

} else {
  throw new Error("not enough arguments.")
}