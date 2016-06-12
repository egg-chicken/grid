Array2D = require('./array2d')
Enum = require('./enum')

module.exports = class Board
  constructor: (width, height) ->
    @table = new Array2D(width, height)

  set: (position, piece) ->
    @table.set(position, piece)

  get: (position, piece) ->
    @table.get(position)

  command: (position, action, args) ->
    switch(action)
      when 'up', 'down', 'left', 'right'
        @_move(position, action)
      when 'attack'
        @_attack(position, args.direction)
      else
        throw new Error('unknown action called')

  isMovable: (position, direction) ->
    next = position[direction]()
    @table.isCover(next) && not(@get(next))

  each: (f) ->
    done = {}
    @table.eachp (piece, point) ->
      if piece && not(done[piece.id]) && piece.isAlive()
        f(piece, point)
        done[piece.id] = true

  min: -> Enum.min.apply(@, arguments)?[1]

  _move: (position, action) ->
    piece = @get(position)
    @set(position[action](), piece)
    @table.delete(position)

  _attack: (position, direction) ->
    target = @get(position[direction]())
    target.damage()
