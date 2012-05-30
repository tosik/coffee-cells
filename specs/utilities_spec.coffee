require "../src/utilities"

describe 'Array', ->
  it '::flatten', ->
    [0, 1, [2, 3], 4].flatten().should.eql [0, 1, 2, 3, 4]
    [0, 1, 2, 3, 4].flatten().should.eql [0, 1, 2, 3, 4]
    [[[4]], 1].flatten().should.eql [[4], 1]

