rimraf = require 'rimraf'
config = require './config.js'
nightmare = require './nightmare.js'

reset = (callback) ->
  nightmare
    .end()
    .then ->
      rimraf "#{config.cachePath}/electronCache", ->
        rimraf "#{config.cachePath}/localStorage", ->
          callback()

# export
module.exports = reset