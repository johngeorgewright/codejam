fs = require 'fs'

module.exports = class InputParser
  constructor: ->
    @cases = []

  caseParser: ->
    throw new Error "#{@constructor.name} does not implement a #caseParser()"

  forEach: (fn, context=this, args...)->
    for lineNum in [0...@length]
      c = @cases[lineNum]
      c = @caseParser c
      fn.call context, c, lineNum + 1, args...

  out: (path=off)->
    out = []
    @forEach (caseResult, caseNum)->
      buf = new Buffer "Case ##{caseNum}: #{caseResult}"
      str = buf.toString 'ascii'
      out.push str
      console.log str
    fs.writeFile path, out.join "\n" if path

  in: (path)->
    input = fs.readFileSync path
    cases = input.toString().match /[^\r\n]+/g
    @length = cases.shift()
    @cases = cases

