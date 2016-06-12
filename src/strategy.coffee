Action = require('./action')

module.exports = class Strategy
  constructor: (@board) ->

  aggressive: (current) ->
    target = @_nearestEnemy(current)
    if not(target)
      new Action('move', @_random(current))
    else if current.distance(target) == 1
      new Action('attack', current.where(target))
    else
      new Action('move', @_approach(current, target))

  difensive: (current)->
    target = @_nearestFriend(current)
    if not(target)
      new Action('move', @_random(current))
    else
      new Action('move', @_approach(current, target))

  _random: (current) ->
    n = Math.floor(Math.random() * Action.DIRECTIONS.length)
    Action.DIRECTIONS[n] if @board.isMovable(current, Action.DIRECTIONS[n])

  _approach: (current, target) ->
    currentDistance = current.distance(target)
    for dir in Action.DIRECTIONS
      continue unless @board.isMovable(current, dir)
      next = current[dir]()
      if next.distance(target) < currentDistance
        return dir
    null

  _nearestFriend: (current)->
    myPiece = @board.get(current)
    @board.min (piece, position) =>
      if myPiece.isFriend(piece) then position.distance(current) else Infinity

  _nearestEnemy: (current)->
    myPiece = @board.get(current)
    @board.min (piece, position) =>
      if myPiece.isEnemy(piece) then position.distance(current) else Infinity

  _nearest: (current) ->
    @board.min (piece, position) =>
      d = position.distance(current)
      if d > 0 then d else Infinity
