fs = require 'fs'
rimraf = require 'rimraf'
config = require '../config'

path = config.tmpPath

cache =
  init: ->
    try # create cache directory in user's home if it need
      fs.statSync path
    catch e
      fs.mkdirSync path
  get: (key) ->
    try
      val = JSON.parse fs.readFileSync "#{path}/#{key}"
    catch e
      val = undefined

    return val
  set: (key, data) ->
    fs.writeFileSync "#{path}/#{key}", JSON.stringify data
  clear: ->
    rimraf.sync path

# export
module.exports = cache