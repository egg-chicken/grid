module.exports = {
  _nearestFriend: (current)->
    myPiece = @board.get(current)
    @board.min (piece, position) ->
      if myPiece.isFriend(piece)
        position.distance(current)
      else
        Infinity

  _nearestEnemy: (current)->
    myPiece = @board.get(current)
    @board.min (piece, position) ->
      if myPiece.isEnemy(piece) && piece.isAlive()
        position.distance(current)
      else
        Infinity

  _nearest: (current) ->
    @board.min (piece, position) ->
      d = position.distance(current)
      if d > 0 then d else Infinity
}
