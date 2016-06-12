DIRECTIONS = require('../action').DIRECTIONS

module.exports = {
  _freeDirections: (current) ->
    dirs = []
    for dir in DIRECTIONS
      dirs.push(dir) if @board.isMovable(current, dir)
    dirs

  _randomDirection: (current) ->
    dirs = @_freeDirections(current)
    dirs[Math.floor(Math.random() * dirs.length)]
}
