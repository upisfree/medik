rimraf = require 'rimraf'
config = require '../config'
nightmare = require '../utils/nightmare'

reset = (callback) ->
  nightmare
    .end()
    .then ->
      rimraf "#{config.tmpPath}/electronCache", ->
        rimraf "#{config.tmpPath}/localStorage", ->
          callback()

# export
module.exports = reset