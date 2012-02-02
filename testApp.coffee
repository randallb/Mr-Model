express = require "express"
coffeescript = require "coffee-script"
_ = require "underscore"
mongoose = require "mongoose"
mongoose.connect "mongodb://int.ksl.com/test"

app = express.createServer()

mrModel = require "./mrmodel"
mrMVC = require "./mrmvc"

mrMVC app, mrModel
console.log mrModel.Model
newModel = new mrModel.Model

newModel.title = "whoa"
newModel.body = "whooooo this is a body."

newModel.save (err) ->
  if err?
    throw err
  else
    console.log "saved new model."

mrModel.Model.find {}, (err, docs) ->
  if err?
    throw err
  else
    console.log docs

app.listen 8080
console.log "listening."
