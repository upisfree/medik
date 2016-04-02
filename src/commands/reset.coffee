rimraf = require 'rimraf'
config = require '../config'
nightmare = require '../utils/nightmare'

reset = (callback) ->
  nightmare
    .end()
    .then ->
      rimraf "#{config.cachePath}/electronCache", ->
        rimraf "#{config.cachePath}/localStorage", ->
          callback()

# export
module.exports = reset