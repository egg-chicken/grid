count = 0

module.exports = class Piece extends require('./module')
  constructor: (@name) ->
    count += 1
    @id = count

  toString: ->
    @name
