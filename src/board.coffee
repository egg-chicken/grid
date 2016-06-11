Array2D = require('./array2d')

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
      else
        throw new Error('unknown action called')

  isAble: (position, action, args) ->
    switch(action)
      when 'up', 'down', 'left', 'right'
        next = position[action]()
        @table.isCover(next)

  each: (f) ->
    done = {}
    @table.eachp (piece, point) ->
      if piece && not(done[piece.id])
        f(piece, point)
        done[piece.id] = true

  _move: (position, action) ->
    piece = @get(position)
    @set(position[action](), piece)
    @table.delete(position)
