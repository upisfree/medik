delta = 75

ooo =
  start: ->
    ooo._interval = setInterval ->
      ooo.step()
    , delta
  stop: ->
    clearInterval ooo._interval

    process.stdout.write '\n'
  step: ->
    if ooo.state > ooo.states.length - 1
      ooo.state = 0

    process.stdout.clearLine()
    process.stdout.cursorTo 0
    process.stdout.write ooo.states[ooo.state] # + '\r'

    ooo.state++
  states: ['o o o o o',
           'O o o o o',
           'O O o o o',
           'O O O o o',
           'O O O O o',
           'O O O O O',
           'o O O O O',
           'o o O O O',
           'o o o O O',
           'o o o o O']
  state: 0
  _interval: null

# export
module.exports = ooo