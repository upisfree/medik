rimraf = require 'rimraf'
nightmare = require './nightmare.js'

reset = (callback) ->
  nightmare
    .end()
    .then ->
      rimraf "#{process.env['HOME']}/.medik/electronCache", ->
        rimraf "#{process.env['HOME']}/.medik/localStorage", ->
          callback()

# export
module.exports = reset