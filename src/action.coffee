module.exports = class Action
  @DIRECTIONS: ['up', 'down', 'left', 'right']

  constructor: (@name, @target) ->
