module.exports = {
  min: (iteratee) ->
    minValue = Infinity
    result = null
    @each ->
      value = iteratee.apply(@, arguments)
      if value < minValue
        minValue = value
        result = arguments
    result
}
