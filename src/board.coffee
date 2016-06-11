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

  _move: (position, action)->
    piece = @table.get(position)
    @table.set(position[action](), piece)
    @table.delete(position)
