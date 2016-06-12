module.exports = class Strategy
  constructor: (@board) ->

  plan: (current)->
    target = @_nearest(current)
    @_approach(current, target)

  _approach: (current, target) ->
    currentDistance = current.distance(target)
    for dir in ['up', 'down', 'left', 'right']
      continue unless @board.isAble(current, dir)
      next = current[dir]()
      if next.distance(target) < currentDistance
        return dir

  _nearest: (current) ->
    @board.min (piece, position) =>
      d = position.distance(current)
      if d > 0 then d else Infinity
