count = 0

module.exports = class Character
  constructor: (@name) ->
    count += 1
    @id = count

  toString: ->
    @name
