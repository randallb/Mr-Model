express = require "express"
coffeescript = require "coffee-script"
_ = require "underscore"

app = express.createServer()

mrModel = require "./mrmodel"
mrMVC = require "./mrmvc"

mrMVC app, mrModel

app.listen 8080
console.log "listening."
