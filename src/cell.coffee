module.exports = class Cell
  constructor: (@state = 0) ->

  exists: ->
    @state isnt 0

  dead: ->
    not @exists()

  lives: ->
    @exists()
