Array2D = require('./array2d')
Enum = require('./enum')

module.exports = class Board
  constructor: (width, height) ->
    @table = new Array2D(width, height)

  set: (position, piece) ->
    @table.set(position, piece)

  get: (position, piece) ->
    @table.get(position)

  command: (position, action) ->
    switch(action.name)
      when 'move' then @_move(position, action.target)
      when 'attack' then @_attack(position, action.target)
      when 'nothing' then return
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
    actor  = @get(position)
    target = @get(position[direction]())
    actor.attack(target)
