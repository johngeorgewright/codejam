fs = require 'fs'

module.exports = class InputParser
  constructor: ->
    @position = 0
    @cases = []

  caseParser: ->
    throw new Error "#{@constructor.name} does not implement a #caseParser()"

  current: ->
    @cases[@position]

  next: ->
    @position++
    @cases[@position]

  previous: ->
    @position--
    @cases[@position]

  valid: ->
    0 <= @position < @length

  reset: ->
    @position = 0

  forEach: (fn)->
    @reset()
    while @valid()
      c = @current()
      c = @caseParser c
      fn.call this, c, @position + 1
      @next()

  out: (path=off)->
    out = []
    caseNum = 1
    @forEach (caseResult)->
      buf = new Buffer "Case ##{caseNum}: #{caseResult}"
      str = buf.toString 'ascii'
      out.push str
      console.log str
      caseNum++
    fs.writeFile path, out.join "\n" if path

  in: (path)->
    input = fs.readFileSync path
    cases = input.toString().match /[^\r\n]+/g
    @length = cases.shift()
    @cases = cases

