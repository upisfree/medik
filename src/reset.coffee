rimraf = require 'rimraf'
nightmare = require './nightmare.js'

reset = (callback) ->
  nightmare
    .end()
    .then ->
      rimraf 'electronCache', ->
        rimraf 'localStorage', ->
          callback()

# export
module.exports = reset