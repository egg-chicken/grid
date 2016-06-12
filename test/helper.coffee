grequire = (hash)->
  for name, path of hash
    try
      global[name] = require("../src/#{path}")
    catch
      global[name] = require(path)

grequire(
  assert: 'assert'
  Module: 'module'
  Point: 'point'
  Array2D: 'array2d'
  Board: 'board'
  Piece: 'piece'
  Strategy: 'strategy'
)
