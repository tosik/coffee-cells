Cell = require "./cell"

Array::flatten = ->
  [].concat.apply([], this)

module.exports = class CellularAutomaton
  constructor: (@size, @deadRules, @bornRules) ->
    @cells = (([0..@size-1].map -> new Cell) for i in [0..@size-1])

  set: (cell, x, y) ->
    @cells[y][x] = cell

  step: ->
    @cells = @next()

  next: ->
    [0..@size-1].map (y) =>
      [0..@size-1].map (x) =>
        @stepCell(x, y)

  stepCell: (x, y) ->
    center = @cell(x, y)
    return new Cell(1) if center.dead() and @lives(x, y).length in @bornRules
    return new Cell(1) if center.lives() and @lives(x, y).length in @deadRules
    new Cell(0)

  neighbors: (x, y) ->
    (
      [y-1..y+1].map (yy) =>
        [x-1..x+1].map (xx) =>
          @cell(xx, yy) unless (x is xx) and (y is yy)
    ).flatten().filter (cell) -> cell?

  cell: (x, y) ->
    try
      @cells[y][x]
    catch e
      new Cell

  # get neighbors live
  lives: (x, y) ->
    @neighbors(x, y).filter (cell) -> cell.lives()

  view: ->
    ([0..@size-1].map (y) =>
      ([0..@size-1].map (x) =>
        @cell(x, y).state
      ).join(" ")).join("\n")
