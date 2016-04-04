# Simple log wrapper
config = require '../config'

if config.isLogEnable
  module.exports = console.log.bind console
else
  module.exports = ->