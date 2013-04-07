fs = require 'fs'

module.exports = class InputParser
  constructor: ->
    @cases = []

  caseParser: (c)->
    c

  forEach: (fn, context=this, args...)->
    for lineNum in [0...@length]
      c = @cases[lineNum]
      c = @caseParser c
      fn.call context, c, lineNum + 1, args...

  @::__defineSetter__ 'filepath', (path)->
    input = fs.readFileSync path
    cases = input.toString().match /[^\r\n]+/g
    @length = cases.shift()
    @cases = cases

