rimraf = require 'rimraf'
nightmare = require './nightmare.js'

reset = (callback) ->
  nightmare
    .end()
    .then ->
      rimraf "#{__dirname}/../tmp/electronCache", ->
        rimraf "#{__dirname}/../tmp/localStorage", ->
          callback()

# export
module.exports = reset