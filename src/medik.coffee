cache = require './utils/cache'
cache.init() # check tmp folder first

argv = require('minimist')(process.argv.slice(2))
nightmare = require './utils/nightmare'
list = require './commands/list'
update = require './commands/update'
reset = require './commands/reset'
help = require './commands/help'

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