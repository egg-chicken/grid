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

  any: (iteratee) ->
    flag = false
    @each ->
      return if flag
      flag = iteratee.apply(@, arguments)
    flag

  find: (iteratee) ->
    found = null
    @each (i)->
      return if found
      found = i if iteratee.apply(@, arguments)
    found
}
