module.exports = class Team
  constructor: (@code)->
    @list = {}

  add: (member) ->
    @list[member.id] = member

  remove: (member) ->
    delete @list[member.id]

  each: (f) ->
    for _key, member of @list
      f(member)
