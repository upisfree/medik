Nightmare = require 'nightmare'
nightmare = Nightmare
  show: false
  paths:
    userData: "#{process.env['HOME']}/.medik/electronCache"

nightmare.viewport 1920, 1080

# export
module.exports = nightmare