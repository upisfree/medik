rimraf = require 'rimraf'
nightmare = require './nightmare.js'

reset = (callback) ->
  nightmare
    .end()
    .then ->
      rimraf 'tmp/electronCache', ->
        rimraf 'tmp/localStorage', ->
          callback()

# export
module.exports = reset