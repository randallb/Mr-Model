_ = require "underscore"

mrMVC = (app, mrModel) ->
  routeKeys = _.keys mrModel.routes
  for route in routeKeys
    for method in _.keys mrModel.routes[route]
      app[method] route, mrModel.beforeResponse, mrModel.routes[route][method]

module.exports = mrMVC

