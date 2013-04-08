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

  out: ->
    @forEach (caseResult, caseNum)->
      console.log "Case ##{caseNum}: #{caseResult}"

  in: (path)->
    input = fs.readFileSync path
    cases = input.toString().match /[^\r\n]+/g
    @length = cases.shift()
    @cases = cases

