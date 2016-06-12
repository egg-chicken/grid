Action = require('./action')
Module = require('./module')

module.exports = class Strategy extends Module
  @include(require('./strategy/nearest'))
  @include(require('./strategy/direction'))

  constructor: (@board) ->

  aggressive: (current) ->
    target = @_nearestEnemy(current)
    if not(target)
      new Action('move', @_randomDirection(current))
    else if current.distance(target) == 1
      new Action('attack', current.where(target))
    else
      new Action('move', @_approach(current, target))

  difensive: (current)->
    target = @_nearestFriend(current)
    if not(target)
      new Action('move', @_randomDirection(current))
    else
      new Action('move', @_approach(current, target))

  _approach: (current, target) ->
    currentDistance = current.distance(target)
    for dir in @_freeDirections(current)
      next = current[dir]()
      if next.distance(target) < currentDistance
        return dir
    @_randomDirection(current)
