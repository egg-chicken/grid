module.exports = class Action
  @DIRECTIONS: ['up', 'down', 'left', 'right']

  constructor: (@name, @target) ->

  randomDirection: ->
    n = Math.floor(Math.random() * Action.DIRECTIONS.length)
    Action.DIRECTIONS[n]
