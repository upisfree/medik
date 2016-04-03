config = require '../config'
Nightmare = require 'nightmare'
nightmare = Nightmare
  show: true
  paths:
    userData: "#{config.tmpPath}/electronCache"

nightmare.viewport 1920, 1080

# export
module.exports = nightmare