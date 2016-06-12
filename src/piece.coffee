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

  isFriend: (piece) ->
    return null if @equal(piece)
    @teamCode && @teamCode == piece.teamCode

  isEnemy: (piece) ->
    return null if @equal(piece)
    not @isFriend(piece)

  equal: (p)->
    @id == p.id
