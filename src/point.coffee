module.exports = class Point
  @random: (xmax, ymax, xmin = 0, ymin = 0) ->
    x = Math.floor(Math.random() * (xmax - xmin)) + xmin
    y = Math.floor(Math.random() * (ymax - ymin)) + ymin
    new Point(x, y)

  constructor: (@x, @y)->

  equal: (point)->
    point && point.x == @x && point.y == @y

  shift: (x, y)->
    new Point(@x+x, @y+y)

  times: (k)->
    new Point(@x*k, @y*k)

  scalar: (k)->
    @times(k)

  up: (y=1)->
    new Point(@x, @y-y)

  down: (y=1)->
    new Point(@x, @y+y)

  left: (x=1)->
    new Point(@x-x, @y)

  right: (x=1)->
    new Point(@x+x, @y)

  distance: (to)->
    Math.abs(@x - to.x) + Math.abs(@y - to.y)

  cover: (point)->
    cov = []
    for x in [@x .. point.x]
      for y in [@y .. point.y]
        cov.push(new Point(x, y))
    cov

  where: (point)->
    dir = null
    if @x == point.x
      if @y > point.y
        dir = "up"
      else if @y < point.y
        dir = "down"
    else if @y == point.y
      if @x > point.x
        dir = "left"
      else if @x < point.x
        dir = "right"
    dir

  to_s: ->
    "#{@x},#{@y}"

  toString: ->
    @to_s()
