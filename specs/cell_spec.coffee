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

  describe 'is constructed by state=1,', ->
    before ->
      @cell = new Cell 1
    it '.exists should return true', ->
      @cell.exists().should.be.true
    it '.dead should return false', ->
      @cell.dead().should.be.false
    it '.lives should return true', ->
      @cell.lives().should.be.true

