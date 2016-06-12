Action = require('./action')
Module = require('./module')

module.exports = class Strategy extends Module
  @include(require('./strategy/nearest'))

  constructor: (@board) ->

  aggressive: (current) ->
    target = @_nearestEnemy(current)
    if not(target)
      new Action('move', @_random(current))
    else if current.distance(target) == 1
      new Action('attack', current.where(target))
    else
      new Action('move', @_approach(current, target) || @_random(current))

  difensive: (current)->
    target = @_nearestFriend(current)
    if not(target)
      new Action('move', @_random(current))
    else
      new Action('move', @_approach(current, target) || @_random(current))

  _random: (current) ->
    dirs = []
    for dir in Action.DIRECTIONS
      dirs.push(dir) if @board.isMovable(current, dir)
    dirs[Math.floor(Math.random() * dirs.length)]

  _approach: (current, target) ->
    currentDistance = current.distance(target)
    for dir in Action.DIRECTIONS
      continue unless @board.isMovable(current, dir)
      next = current[dir]()
      if next.distance(target) < currentDistance
        return dir
    null
