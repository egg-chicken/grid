Point = require('./point')

class OutOfBoundsError extends Error
  constructor: (x, y)->
    @message = "out of bounds #{x}, #{y}"

class Array2D
  constructor:(width_or_nested_array, height, value) ->
    if width_or_nested_array instanceof Array
      @_initialize_by_nested_array(width_or_nested_array)
    else
      @_initialize_by_size_and_value.apply(@, arguments)

  set: (x, y, value)->
    if x instanceof Point
      value = y
      y = x.y
      x = x.x
    @_check(x, y)
    @rows[y][x] = value

  get: (x, y)->
    if x instanceof Point
      y = x.y
      x = x.x
    @_check(x, y)
    @rows[y][x]

  delete: (x, y)->
    if x instanceof Point
      @set(x, null)
    else
      @set(x, y, null)

  each: (f)->
    for y in [0...@height]
      for x in [0...@width]
        f(@rows[y][x], x, y)
    @

  eachp: (f)->
    @each (val, x, y) -> f(val, new Point(x, y))

  eachRound: (f)->
    @each (val, x, y) =>
      if(x == 0 || y == 0 || x == @width-1 || y == @height-1)
        f(val, x, y)

  # 時計回りに90度回転した Array2D を作成して返す
  rotate: ->
    a = new Array2D(@height, @width)
    @each (val, x, y) => a.set(@height-1-y, x, val)
    a

  clear: (value=null)->
    @eachp (_, p) -> a.set(p, value)

  toString: ->
    @rows.join("\n")

  isCover: (p) ->
    p.x >= 0 && p.y >= 0 && p.y < @height && p.x < @width

  _initialize_by_size_and_value: (@width, @height, value) ->
    @rows = []
    for y in [0...@height]
      @rows[y] = []
      for x in [0...@width]
        @rows[y][x] = value
    @

  _initialize_by_nested_array: (nested_array)->
    w = nested_array[0].length
    h = nested_array.length
    array2d = @_initialize_by_size_and_value(w, h)
    array2d.each (_, x, y) -> array2d.set(x, y, nested_array[y][x])

  _check: (x, y) ->
    if x < 0 || y < 0 || y >= @height || x >= @width
      throw new OutOfBoundsError(x, y)

module.exports = Array2D
