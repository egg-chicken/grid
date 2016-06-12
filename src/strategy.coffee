module.exports = class Strategy
  constructor: (@board) ->

  aggressive: (current) ->
    target = @_nearestEnemy(current)
    @_approach(current, target)

  difensive: (current)->
    target = @_nearestFriend(current)
    @_approach(current, target)

  _approach: (current, target) ->
    currentDistance = current.distance(target)
    for dir in ['up', 'down', 'left', 'right']
      continue unless @board.isAble(current, dir)
      next = current[dir]()
      if next.distance(target) < currentDistance
        return dir

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
