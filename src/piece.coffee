count = 0

module.exports = class Piece
  constructor: (@name) ->
    count += 1
    @id = count

  toString: ->
    @name
