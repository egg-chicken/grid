count = 0

module.exports = class Piece extends require('./module')
  constructor: (options = {}) ->
    @name = options.name
    @teamCode = options.teamCode
    count += 1
    @id = count

  toString: ->
    @name

  damage: ->
    @dead = true

  isDead: ->
    @dead

  isAlive: ->
    not @dead
