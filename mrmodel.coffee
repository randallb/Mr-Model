# **MrModel** is a style of module for Express. It is intended as a way to 
# easily encapsulate related code within one file, while providing an easy to 
# code and use syntax.
# 
# This file describes the base from which all classes are extended.
inflect = require "inflect"
mongoose = require "mongoose"
Schema = mongoose.Schema
ObjectId = mongoose.ObjectId

class MrModel
# The name serves as a base for the URL structure.
# Plural allows someone to use an inflection lib of their choice.
  @name: "MrModel"
  @plural: inflect.pluralize @name
# Methods are class specific methods, which probably will be used in routes.
  @methods:
    logger: () ->
      console.log "I'm a custom method!"
# Methods conforming to the connect middleware standard
  @middleware:
    logger: (req, res, next) ->
      console.log "middlewared"
      next()
    pre: (req, res, next) ->
      console.log "pre!"
      next()
  @schema: new Schema
    title: String
    body: String
    timestamp: type: Date, default: Date.now

# Schema middleware goes here.
  @schema.pre 'save', (next) =>
    console.log "about to save!"
    @methods.logger()
    next()

# The routes object is where we define the custom routes for the module. We use the name
# as the route key, and then define the type of method beneath it. The params
# below could be either arrays of middleware, or a single function.
  @routes:
    "/":
      get: [@middleware.logger, (req, res, next) =>
        @methods.logger()
        res.send "hello world! I'm Mr. Model."
      ]
      post: (req, res, next) ->
        res.send "Hello world! Posted Mr. Model."
      put: (req, res, next) ->
        res.send "I was updated and stuff. I'm Mr. Model."
      delete: (req, res, next) ->
        res.send "I should have been deleted, but I wasn't. I'm Mr. Model."
    "/awesome":
      get: (req, res, next) ->
        console.log "yo, that's what it's all about."
        res.send "yeaaah."
# We love Mongoose, so we're following Mongoose's schema pattern here.
# Obviously you could rip this out, include a separate model file, etc.
#


  @Model: mongoose.model @name, @schema
# Lastly, we've included a beforeResponse object which will be prepended
# before any route middleware runs. An example use might be user authorization
# middleware, or logging.
  @beforeResponse: [@middleware.pre]

# We export out the class so MrMVC can parse it.
module.exports = MrModel

