rimraf = require 'rimraf'
config = require '../config'
nightmare = require '../utils/nightmare'
cache = require '../utils/cache'

reset = (callback) ->
  nightmare
    .end()
    .then ->
      rimraf "#{config.tmpPath}/electronCache", ->
        cache.clear()

        callback()

# export
module.exports = reset