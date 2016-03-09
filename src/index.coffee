argv = require('minimist')(process.argv.slice(2))
nightmare = require './nightmare.js'
list = require './list.js'
update = require './update.js'
reset = require './reset.js'
help = require './help.js'

switch argv._[0]
  when 'update'
    update argv.id, ->
      nightmare.end().then ->
  when 'list'
    list ->
      nightmare.end().then ->
  when 'reset'
    reset ->
      console.log 'Yeah, fresh start!'
  when 'help'
    help()

    nightmare.end().then ->
  else
    nightmare.end().then ->
      console.log 'Unknown command! Use \'help\' command to solve this.'