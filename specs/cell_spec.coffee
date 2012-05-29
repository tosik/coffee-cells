Cell = require '../src/cell'

describe 'Cell', ->

  describe 'is constructed by default,', ->
    before ->
      @cell = new Cell
    it '.exists should return false', ->
      @cell.exists().should.be.false
    it '.dead should return true', ->
      @cell.dead().should.be.true
    it '.lives should return false', ->
      @cell.lives().should.be.false

