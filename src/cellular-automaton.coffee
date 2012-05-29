Cell = require "./cell"

module.exports = class CellularAutomaton
  constructor: (@size) ->
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
    if center.dead()
      switch @lives(x, y).length
        when 3 then return new Cell(1)
        else return new Cell(0)
    if center.lives()
      switch @lives(x, y).length
        when 2, 3 then return new Cell(1)
        else return new Cell(0)


  neighbors: (x, y) ->
    [].concat.apply([], (
      [y-1..y+1].map (yy) =>
        [x-1..x+1].map (xx) =>
          @cell(xx, yy) unless (x == xx) and (y == yy)
    )).filter (cell) -> cell?

  cell: (x, y) ->
    return new Cell if @cells[y] is undefined
    @cells[y][x] or new Cell

  # get neighbors live
  lives: (x, y) ->
    @neighbors(x, y).filter (cell) -> cell.lives()

  view: ->
    ([0..@size-1].map (y) =>
      ([0..@size-1].map (x) =>
        @cell(x, y).state
      ).join(" ")).join("\n")
