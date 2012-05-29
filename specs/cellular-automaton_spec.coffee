CellularAutomaton = require '../src/cellular-automaton'
Cell = require '../src/cell'

describe 'CellularAutomaton', ->

  describe 'is constructed by size=3,', ->
    before ->
      @ca = new CellularAutomaton 3
    it 'has .step', ->
      @ca.step.should.exist
    it '.size should be 3', ->
      @ca.size.should.equal 3
    it '.cells should be an instance of array', ->
      @ca.cells.should.be.an.instanceof(Array)
    it '.cells\' size should be 3x3', ->
      @ca.cells.length.should.equal 3
      @ca.cells.map (arr) -> arr.length.should.equal 3
    it '.cells should be filled with dead cells', ->
      @ca.cells.map (arr) ->
        arr.map (value) -> value.dead().should.be.true
    it '.cell(1, 1) should exist', ->
      @ca.cell(1, 1).should.exist
    it '.cell(-1, -1) should not exist', ->
      @ca.cell(-1, -1)?.should.not.exist
    it 'length of .neighbors(1, 1) should return 8', ->
      @ca.neighbors(1, 1).length.should.equal 8

    describe 'and set cells', ->
      before ->
        @ca.set(new Cell(1), 0, 0)
        @ca.set(new Cell(1), 1, 2)
      it '.cell should return cell lives', ->
        @ca.cell(0, 0).lives().should.be.true
        @ca.cell(0, 1).lives().should.be.false
      it '.lives should return 2 cells', ->
        @ca.lives(1, 1).length.should.equal 2

  describe 'run .step', ->
    before ->
      @ca = new CellularAutomaton 3
      @ca.set(new Cell(1), 0, 0)
      @ca.set(new Cell(1), 1, 0)
      @ca.set(new Cell(1), 2, 0)
      @ca.set(new Cell(1), 1, 1)
      @ca.set(new Cell(1), 2, 1)
    it ".step", ->
      @ca.step()
      @ca.cell(0, 0).lives().should.be.true
      @ca.cell(1, 0).lives().should.be.false
      @ca.step()
      @ca.cell(0, 0).lives().should.be.false
      @ca.cell(1, 0).lives().should.be.false
