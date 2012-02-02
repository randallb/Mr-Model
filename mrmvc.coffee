debug = require("debug")("mrmvc")
_ = require "underscore"

mrMVC = (app, mrModel) ->
  routeKeys = _.keys mrModel.routes
  for route in routeKeys
    for method in _.keys mrModel.routes[route]
      app[method] "/#{mrModel.name}#{route}", mrModel.beforeResponse, mrModel.routes[route][method]
      debug "Created route for app[#{method}] \"/#{mrModel.name}#{route}\", mrModel.beforeResponse, mrModel.routes[#{route}][#{method}]"


module.exports = mrMVC

