count = 0

module.exports = class Piece extends require('./module')
  constructor: (options = {}) ->
    @name = options.name
    @teamCode = options.teamCode
    count += 1
    @id = count
    @health = options.health || 1
    @power = options.power || 1

  toString: ->
    @name

  attack: (target)->
    target.damage(@power)

  damage: (point)->
    @health -= point
    if @health <= 0
      @health = 0
      @dead = true

  isDead: ->
    @dead

  isAlive: ->
    not @dead

  isFriend: (piece) ->
    return null if @equal(piece)
    @teamCode && @teamCode == piece.teamCode

  isEnemy: (piece) ->
    return null if @equal(piece)
    not @isFriend(piece)

  equal: (p)->
    @id == p.id
