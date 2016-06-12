module.exports = class Strategy
  DIRECTIONS = ['up', 'down', 'left', 'right']

  constructor: (@board) ->

  aggressive: (current) ->
    target = @_nearestEnemy(current)
    @_approach(current, target) || @_random(current)

  difensive: (current)->
    target = @_nearestFriend(current)
    @_approach(current, target) || @_random(current)

  _random: (current) ->
    n = Math.floor(Math.random() * DIRECTIONS.length)
    DIRECTIONS[n] if @board.isMovable(current, DIRECTIONS[n])

  _approach: (current, target) ->
    currentDistance = current.distance(target)
    for dir in DIRECTIONS
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
