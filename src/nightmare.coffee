Nightmare = require 'nightmare'
nightmare = Nightmare
  show: false
  paths:
    userData: "#{__dirname}/../tmp/electronCache"

nightmare.viewport 1920, 1080

# export
module.exports = nightmare