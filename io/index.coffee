fs = require 'fs'

module.exports = class BaseIO
  constructor: ->
    @position = 0
    @lines = []

  caseParser: ->
    throw new Error "#{@constructor.name} does not implement a #caseParser()"

  current: ->
    @lines[@position]

  next: ->
    @position++
    @lines[@position]

  previous: ->
    @position--
    @lines[@position]

  valid: ->
    0 <= @position < @lines.length

  reset: ->
    @position = 0

  forEach: (fn)->
    @reset()
    caseNum = 1
    while @valid()
      c = @current()
      c = @caseParser c
      fn.call this, c, caseNum
      @next()
      caseNum++

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
    lines = input.toString().match /[^\r\n]+/g
    @length = lines.shift()
    @lines = lines

