module.exports = class Action
  @DIRECTIONS: ['up', 'down', 'left', 'right']

  constructor: (@name, @target) ->
    unless @target
      if @name == 'move' || @name == 'attack'
        @name = 'nothing'
