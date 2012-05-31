Cell = require "./cell"
require "./utilities"

boxMap = (sizex, sizey, f) ->
  [0..sizey-1].map (y) ->
    [0..sizex-1].map (x) ->
      f(x, y)

module.exports = class CellularAutomaton
  constructor: (@size, @deadRules, @bornRules) ->
    @cells = boxMap @size, @size, -> new Cell

  set: (cell, x, y) ->
    @cells[y][x] = cell

  step: ->
    @cells = @next()

  next: ->
    boxMap @size, @size, (x, y) =>
      @stepCell(x, y)

  stepCell: (x, y) ->
    center = @cell(x, y)
    return new Cell(1) if center.dead() and @lives(x, y).length in @bornRules
    return new Cell(1) if center.lives() and @lives(x, y).length in @deadRules
    new Cell(0)

  neighbors: (x, y) ->
    (
      boxMap 3, 3, (xx, yy) =>
        @cell(x + xx - 1, y + yy - 1) unless (xx is 1) and (yy is 1)
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
